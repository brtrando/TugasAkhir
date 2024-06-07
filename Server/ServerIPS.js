var express = require('express');
var fs = require('fs');
var bodyparser = require('body-parser');
var mysql = require('mysql');
var mqtt = require('mqtt');
var app = express();
const path = require("path");

app.use(bodyparser.json());
app.use(express.json());

const conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'ips_database'
});

conn.connect(function(err){
    if (err) throw err;
    console.log("MySQL connected...");
    updateMaxBeacons();
});

// MQTT Connection
var mqttClient = mqtt.connect('mqtt://192.168.107.59', {
    port: 1883,
    username: 'ta_ips'
});

var data1, data2, data3;
var globalDeviceName = "";
var globalIdBeacon = null;
var globalIdTag = null;

mqttClient.on('connect', function () {
    console.log("MQTT connected...");
    subscribeToMqttTopics();
    mqttClient.subscribe('maxbeaconserver', function (err) {
        if (err) {
            console.error("Failed to subscribe to MQTT topic:", err);
        } else {
            console.log("Subscribed to MQTT topic: maxbeaconserver");
        }
    });
});

mqttClient.on('message', function (topic, message) {
    if (topic === 'rssible') {
        parseAndInsertRSSIBLEMessage(message.toString());
    } else if (topic === 'rangeuwb') {
        parseAndInsertRangeMessage(message.toString());
    } else if (topic === 'tag') {
        parseAndInsertTagMessage(message.toString());
    }
    if (topic === 'maxbeaconserver') {
        MAX_BEACONS = parseInt(message.toString(), 10);
        console.log("Updated MAX_BEACONS to:", MAX_BEACONS);
    }
});

function parseAndInsertRSSIBLEMessage(message) {
    if (!globalIdTag) {
        console.error("Tag ID is not set. Cannot process RSSI BLE message.");
        return;
    }
    const lines = message.split('\n');
    lines.forEach(line => {
        const parts = line.split(':');
        if (parts.length === 2) {
            const deviceNamePart = parts[0].trim();
            const rssi = parseInt(parts[1].trim(), 10);

            const match = deviceNamePart.match(/Beacon (\d+)/);
            if (match) {
                const idBeacon = parseInt(match[1], 10);
                const deviceName = `Beacon ${idBeacon}`;
                globalDeviceName = deviceName;
                globalIdBeacon = idBeacon;

                toDatabaseRSSIBLE(globalIdTag, idBeacon, rssi);

                if (idBeacon === 1) {
                    data1 = rssi;
                } else if (idBeacon === 2) {
                    data2 = rssi;
                } else if (idBeacon === 3) {
                    data3 = rssi;
                }
                console.log("Beacon(BLE) " + idBeacon + ": (RSSI " + rssi + ")");

                if (globalDeviceName && globalIdBeacon !== null) {
                    toDatabaseLISTBEACON(globalIdBeacon, globalDeviceName);
                }
                performTrilaterationRSSI();
            }
        }
    });
}

function parseAndInsertRangeMessage(message) {
    if (!globalIdTag) {
        console.error("Tag ID is not set. Cannot process range message.");
        return;
    }
    const lines = message.split('\n');
    lines.forEach(line => {
        const parts = line.split(':');
        if (parts.length === 2) {
            const idBeacon = parseInt(parts[0].trim(), 10);
            const dist = parseFloat(parts[1].trim());

            toDatabaseRangeUWB(globalIdTag, idBeacon, dist);
            console.log("Beacon(UWB) " + idBeacon + ": (Dist " + dist + ")");

            if (idBeacon === 1) {
                data1 = dist;
            } else if (idBeacon === 2) {
                data2 = dist;
            } else if (idBeacon === 3) {
                data3 = dist;
            }
            performTrilaterationUWB();
        }
    });
}

function parseAndInsertTagMessage(message) {
    const parts = message.trim().split(' ');
    if (parts.length === 2 && parts[0] === "Tag") {
        globalIdTag = parseInt(parts[1], 10);
        if (!isNaN(globalIdTag)) {
            console.log("Tag ID set to:", globalIdTag);
        } else {
            console.error("Failed to parse Tag ID from message:", message);
            globalIdTag = null;
        }
    }
}

function toDatabaseRSSIBLE(idTag, idBeacon, rssi) {
    const query = 'INSERT INTO rssible (idTag, idBeacon, rssi) VALUES (?, ?, ?)';
    conn.query(query, [idTag, idBeacon, rssi], function(err, results) {
        if (err) throw err;
        console.log("Data inserted:", { idBeacon, rssi });
    });
}

function toDatabaseRangeUWB(idTag, idBeacon, dist) {
    const query = 'INSERT INTO rangeuwb (idTag, idBeacon, dist) VALUES (?, ?, ?)';
    conn.query(query, [idTag, idBeacon, dist], function(err, results) {
        if (err) throw err;
        console.log("Data inserted into rangeuwb:", { idBeacon, dist });
    });
}

function toDatabasePosition(idTag, tipe, xtag, ytag) {
    const query = 'INSERT INTO koordinattag (idTag, tipe, xtag, ytag) VALUES (?, ?, ?, ?)';
    conn.query(query, [idTag, tipe, xtag, ytag], function(err, results) {
        if (err) throw err;
        console.log("Position data inserted:", { xtag, ytag });
    });
}

function toDatabaseLISTBEACON(globalIdBeacon, globalDeviceName) {
    var sql = "INSERT INTO listbeacon (idBeacon, DeviceName) VALUES (?, ?) ON DUPLICATE KEY UPDATE DeviceName = ?";
    conn.query(sql, [globalIdBeacon, globalDeviceName, globalDeviceName], function (err, result) {
        if (err) {
            console.error("Error while inserting data into listbeacon table:", err);
        } else {
            // console.log("Inserted into listbeacon database: idBeacon: " + globalIdBeacon + " DeviceName: " + globalDeviceName);
        }
    });
    globalDeviceName = "";
    globalIdBeacon = null;
}

function updateMaxBeacons() {
    var sql = "SELECT COUNT(*) AS total FROM listbeacon";
    conn.query(sql, function (err, result) {
        if (err) {
            console.error("Error while fetching total beacons from database:", err);
        } else {
            MAX_BEACONS = result[0].total;
            console.log("Updated MAX_BEACONS to:", MAX_BEACONS);
            mqttClient.publish('maxbeaconserver', MAX_BEACONS.toString(), function(err) {
                if (err) {
                    console.error("Error publishing MAX_BEACONS:", err);
                } else {
                    console.log("Published MAX_BEACONS:", MAX_BEACONS);
                }
            });
            subscribeToMqttTopics();
        }
    });
}

function getBeaconCoordinates(callback) {
    var query = 'SELECT idBeacon, x, y FROM listbeacon WHERE idBeacon IN (1, 2, 3)';
    conn.query(query, function(err, results) {
        if (err) {
            console.error("Error fetching beacon coordinates from database:", err);
            callback(err, null);
        } else {
            // Ubah format hasil query menjadi objek dengan idBeacon sebagai kunci
            var beaconCoordinates = {};
            results.forEach(result => {
                beaconCoordinates[result.idBeacon] = { x: result.x, y: result.y };
            });
            callback(null, beaconCoordinates);
        }
    });
}

function getLatestDataFromDatabaseBLE(callback) {
    var query = 'SELECT rssi, idBeacon FROM rssible WHERE time = (SELECT MAX(time) FROM rssible) AND idBeacon IN (1, 2, 3)';
    conn.query(query, function(err, results) {
        if (err) {
            console.error("Error fetching latest data from database:", err);
            callback(err, null);
        } else {
            callback(null, results); // Mengembalikan hasil query (data terbaru)
        }
    });
}


function getLatestDataFromDatabaseUWB(callback) {
    var query = 'SELECT dist, idBeacon FROM rangeuwb WHERE time = (SELECT MAX(time) FROM rangeuwb) AND idBeacon IN (1, 2, 3)'; 
    conn.query(query, function(err, results) {
        if (err) {
            console.error("Error fetching latest data from database:", err);
            callback(err, null);
        } else {
            callback(null, results); // Mengembalikan hasil query (data terbaru)
        }
    });
}

function subscribeToMqttTopics() {
    var rssible = 'rssible';
    var rangeuwb = 'rangeuwb';
    var tagTopic = 'tag';
    mqttClient.subscribe(rssible, function (err) {
        if (err) {
            console.error("Failed to subscribe to MQTT topic:", err);
        } else {
            console.log("Subscribed to MQTT topic:", rssible);
        }
    });
    mqttClient.subscribe(rangeuwb, function (err) {
        if (err) {
            console.error("Failed to subscribe to MQTT topic:", err);
        } else {
            console.log("Subscribed to MQTT topic:", rangeuwb);
        }
    });
    mqttClient.subscribe(tagTopic, function (err) {
        if (err) {
            console.error("Failed to subscribe to MQTT topic:", err);
        } else {
            console.log("Subscribed to MQTT topic:", tagTopic);
        }
    });
}

function calculateDistance(rssi) {
    var A = -50;
    var n = -1 * ((rssi + A) / (10 * Math.log10(50)));
    return Math.pow(10, (A - (rssi)) / (10 * n));
}

function performTrilaterationRSSI() {
    var tipe = 'BLE';
    // var beacon1 = { x: 0, y: 0 };
    // var beacon2 = { x: 6.6, y: 1.8 };
    // var beacon3 = { x: 0, y: 4.8 };
//================= UNTUK MENGUKUR JARAK SAJA ANTARA BEACON DENGAN TAG =======================
//     getLatestDataFromDatabaseBLE(function(err, results) {
//         if (err || !results) {
//             console.error("Error fetching latest data from database:", err);
//             return;
//         }

//         // Inisialisasi variabel untuk menyimpan data RSSI
//         var rssi1, rssi2, rssi3;

//         // Loop melalui hasil query dan simpan data RSSI ke variabel yang sesuai
//         results.forEach(result => {
//             const idBeacon = result.idBeacon;
//             const rssi = result.rssi;

//             if (idBeacon === 1) {
//                 rssi1 = rssi;
//             } else if (idBeacon === 2) {
//                 rssi2 = rssi;
//             } else if (idBeacon === 3) {
//                 rssi3 = rssi;
//             }
//         });

//         var d1 = calculateDistance(rssi1);
//         var d2 = calculateDistance(rssi2);
//         var d3 = calculateDistance(rssi3);

//         console.log("Jarak D1 :", d1);
//         // console.log("Jarak D2 :", d2);
//         // console.log("Jarak D3 :", d3);
//     });
// }

    // ==================Ambil data terbaru dari database rssible=======================
    //ambil koordinat beacon dari database
    getBeaconCoordinates(function(err, beaconCoordinates) {
        if (err || !beaconCoordinates) {
            console.error("Error fetching beacon coordinates from database:", err);
            return;
        }

        // Pastikan koordinat beacon sudah tersedia
        if (beaconCoordinates.length < 3) {
            console.error("Insufficient beacon coordinates for trilateration calculation.");
            return;
        }

        // Ambil data RSSI terbaru dari database
        getLatestDataFromDatabaseBLE(function(err, results) {
            if (err || !results) {
                console.error("Error fetching latest data from database:", err);
                return;
            }

            // Inisialisasi variabel untuk menyimpan data RSSI
            var rssiData = {};

            // Loop melalui hasil query dan simpan data RSSI ke variabel yang sesuai
            results.forEach(result => {
                const idBeacon = result.idBeacon;
                const rssi = result.rssi;
                rssiData[idBeacon] = rssi;
            });

            // Pastikan semua data RSSI sudah tersedia
            if (!rssiData[1] || !rssiData[2] || !rssiData[3]) {
                console.error("Missing RSSI data for trilateration calculation.");
                return;
            }

            // Hitung jarak dari data RSSI
            var d1 = calculateDistance(rssiData[1]);
            var d2 = calculateDistance(rssiData[2]);
            var d3 = calculateDistance(rssiData[3]);

            console.log("Jarak D1 :", d1);
            console.log("Jarak D2 :", d2);
            console.log("Jarak D3 :", d3);

            // Hitung posisi berdasarkan trilateration
            var position = trilateration(beaconCoordinates[1], d1, beaconCoordinates[2], d2, beaconCoordinates[3], d3);
            console.log("Estimated position (x, y):", position.x, position.y);

            // Simpan posisi ke database dan terbitkan ke MQTT
            toDatabasePosition(globalIdTag, tipe, position.x, position.y);
            mqttClient.publish('koordinattag', `x: ${position.x} y: ${position.y}`, function(err) {
                if (err) {
                    console.error("Error publishing BLE coordinates:", err);
                } else {
                    console.log("Published BLE coordinates:", { x: position.x, y: position.y });
                }
            });
        });
    });
}


function performTrilaterationUWB() {
    var tipe = 'UWB';
    // var beacon1 = { x: 0, y: 0 };
    // var beacon2 = { x: 6, y: 1.8 };
    // var beacon3 = { x: 0, y: 4.8 };
//===========================UNTUK MENGUKUR JARAK SAJA ANTARA BEACON DENGAN TAG=======
//     getLatestDataFromDatabaseUWB(function(err, results) {
//         if (err || !results) {
//             console.error("Error fetching latest data from database:", err);
//             return;
//         }

//         // Inisialisasi variabel untuk menyimpan data jarak
//         var dist1, dist2, dist3;

//         // Loop melalui hasil query dan simpan data jarak ke variabel yang sesuai
//         results.forEach(result => {
//             const idBeacon = result.idBeacon;
//             const dist = result.dist;

//             if (idBeacon === 1) {
//                 dist1 = dist;
//             } else if (idBeacon === 2) {
//                 dist2 = dist;
//             } else if (idBeacon === 3) {
//                 dist3 = dist;
//             }
//         });
//     });
// }
//==================================================================================


// ==================Ambil data terbaru dari database rangeuwb=======================
    // Ambil koordinat beacon dari database
    getBeaconCoordinates(function(err, beaconCoordinates) {
        if (err || !beaconCoordinates) {
            console.error("Error fetching beacon coordinates from database:", err);
            return;
        }

        // Pastikan koordinat beacon sudah tersedia
        if (beaconCoordinates.length < 3) {
            console.error("Insufficient beacon coordinates for trilateration calculation.");
            return;
        }

        // Ambil data jarak terbaru dari database
        getLatestDataFromDatabaseUWB(function(err, results) {
            if (err || !results) {
                console.error("Error fetching latest data from database:", err);
                return;
            }

            // Inisialisasi variabel untuk menyimpan data jarak
            var distData = {};

            // Loop melalui hasil query dan simpan data jarak ke variabel yang sesuai
            results.forEach(result => {
                const idBeacon = result.idBeacon;
                const dist = result.dist;
                distData[idBeacon] = dist;
            });

            // Pastikan semua data jarak sudah tersedia
            if (!distData[1] || !distData[2] || !distData[3]) {
                console.error("Missing dist data for trilateration calculation.");
                return;
            }

            // Hitung posisi berdasarkan trilateration
            const position = trilateration(beaconCoordinates[1], distData[1], beaconCoordinates[2], distData[2], beaconCoordinates[3], distData[3]);
            console.log("Tag position: (" + position.x + ", " + position.y + ")");

            // Simpan posisi ke database dan terbitkan ke MQTT
            toDatabasePosition(globalIdTag, tipe, position.x, position.y);

            mqttClient.publish('koordinattag', `x: ${position.x} y: ${position.y}`, function(err) {
                if (err) {
                    console.error("Error publishing UWB coordinates:", err);
                } else {
                    console.log("Published UWB coordinates:", { x: position.x, y: position.y });
                }
            });
        });
    });
}


function trilateration(beacon1, d1, beacon2, d2, beacon3, d3) {
    var x1 = beacon1.x;
    var y1 = beacon1.y;
    var x2 = beacon2.x;
    var y2 = beacon2.y;
    var x3 = beacon3.x;
    var y3 = beacon3.y;

    var A = 2 * x2 - 2 * x1;
    var B = 2 * y2 - 2 * y1;
    var C = d1 * d1 - d2 * d2 - x1 * x1 + x2 * x2 - y1 * y1 + y2 * y2;
    var D = 2 * x3 - 2 * x2;
    var E = 2 * y3 - 2 * y2;
    var F = d2 * d2 - d3 * d3 - x2 * x2 + x3 * x3 - y2 * y2 + y3 * y3;

    var denominator = (A * D - B * C);
    if (denominator === 0) {
        console.error("Denominator in trilateration calculation is zero, which means points are collinear or distances are incorrect.");
        return { x: NaN, y: NaN };
    }

    var x = (C * E - F * B) / (E * A - B * D);
    var y = (C * D - A * F) / (B * D - A * E);

    return { x: x, y: y };
}

var server = app.listen(7000, function() {
    var host = server.address().address;
    var port = server.address().port;
    console.log("Express app listening at http://%s:%s", host, port);
});
