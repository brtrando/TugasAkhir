#include <BLEDevice.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <WiFi.h>
#include <PubSubClient.h>
#include <SPI.h>
#include <DW1000Ranging.h>
#include "DW1000.h"

// Wi-Fi and MQTT configuration
const char* ssid = "Hii";
const char* password = "rgcc2353";
const char* mqtt_server = "192.168.107.59";
const char* mqtt_username = "ta_ips";
const char* mqtt_password = "";
const int mqtt_port = 1883;
const char* mqtt_topic_base = "rssible";
const char* mqtt_topic_tag = "tag";
const char* mqtt_topic_uwb = "rangeuwb";
const char* mqtt_topic_spb = "spb";  // MQTT topic to listen for the "hello" message
const char* mqtt_topic_maxbeacon = "maxbeaconserver";  // MQTT topic to publish the number of detected beacons

WiFiClient espClient;
PubSubClient client(espClient);

// Kalman Filter variables
float kalman_R = 1;
float kalman_Q = 1;
float kalman_A = 1;
float kalman_B = 0;
float kalman_C = 1;
float kalman_P = 0;
float kalman_X = 0;

// BLE configuration
struct RSSIData {
  String deviceName;
  int rssiValue;
  int filteredRssiValue;
  bool active;
  unsigned long lastSeen;
};

RSSIData rssiData[50];
const unsigned long beaconTimeout = 10000; // 10 seconds
int scanTime = 2; // In seconds
unsigned long lastPublishTimeBLE = 0;
unsigned long publishIntervalBLE = 5000; // Interval in milliseconds
int detectedBeacons = 0; // To keep track of the number of detected beacons

static BLEUUID serviceUUID("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
static BLEUUID charUUID("beb5483e-36e1-4688-b7f5-ea07361b26a8");
BLEScan *pBLEScan;

// Kalman Filter function
float kalmanFilter(float measurement, float previousFilteredValue) {
  float prediction = kalman_A * previousFilteredValue;
  kalman_P = kalman_A * kalman_P * kalman_A + kalman_Q;
  float K = kalman_P * kalman_C / (kalman_C * kalman_P * kalman_C + kalman_R);
  float filteredValue = prediction + K * (measurement - kalman_C * prediction);
  kalman_P = (1 - K * kalman_C) * kalman_P;
  return filteredValue;
}

class MyAdvertisedDeviceCallbacks : public BLEAdvertisedDeviceCallbacks {
  void onResult(BLEAdvertisedDevice advertisedDevice) {
    String deviceName = String(advertisedDevice.getName().c_str());
    int rssiValue = advertisedDevice.getRSSI();
    BLEUUID serviceUUID = advertisedDevice.getServiceUUID();
    BLEUUID serviceUUIDToScan("4fafc201-1fb5-459e-8fcc-c5c9c331914b");

    if (serviceUUID.equals(serviceUUIDToScan)) {
      int index = -1;
      for (int i = 0; i < detectedBeacons; i++) {
        if (rssiData[i].deviceName == deviceName) {
          index = i;
          break;
        }
      }
      if (index != -1) {
        rssiData[index].rssiValue = rssiValue;
        rssiData[index].filteredRssiValue = kalmanFilter(rssiValue, rssiData[index].filteredRssiValue);
        rssiData[index].active = true;
        rssiData[index].lastSeen = millis();
      } else {
        for (int i = 0; i < 50; i++) {
          if (rssiData[i].deviceName.isEmpty()) {
            rssiData[i].deviceName = deviceName;
            rssiData[i].rssiValue = rssiValue;
            rssiData[i].filteredRssiValue = kalmanFilter(rssiValue, rssiData[i].filteredRssiValue);
            rssiData[i].active = true;
            rssiData[i].lastSeen = millis();
            detectedBeacons++;
            publishDetectedBeacons();  // Publish the number of detected beacons
            break;
          }
        }
      }
      Serial.println("RSSI Beacon " + deviceName + ": " + String(rssiValue));
    }
  }
};

// UWB configuration
#define TAG_ADD "7D:00:22:EA:82:60:3B:9C"
struct UWBData {
  String deviceName;
  float rangeValue;
};
UWBData uwbdata[50];
#define SPI_SCK 18
#define SPI_MISO 19
#define SPI_MOSI 23
#define DW_CS 4
#define PIN_RST 27
#define PIN_IRQ 34

unsigned long lastPublishTimeUWB = 0;
unsigned long publishIntervalUWB = 5000;

// Mode and timer variables
bool useBLE = true;
unsigned long uwbStartTime = 0;
const unsigned long uwbDuration = 5 * 60 * 1000; // 5 minutes in milliseconds

void setup_wifi() {
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32Client", mqtt_username, mqtt_password)) {
      Serial.println("connected");
      client.subscribe(mqtt_topic_spb); // Subscribe to the MQTT topic for switching modes
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void publishRSSIData() {
  String mqtt_payload = "";
  for (int i = 0; i < detectedBeacons; i++) {
    if (!rssiData[i].deviceName.isEmpty()) {
      mqtt_payload += rssiData[i].deviceName + " : " + String(rssiData[i].filteredRssiValue) + "\n";
    }
  }
  if (!mqtt_payload.isEmpty()) {
    client.publish(mqtt_topic_base, mqtt_payload.c_str());
    client.publish(mqtt_topic_tag, "Tag 1");
    Serial.println(mqtt_topic_base);
    Serial.println("TagId published to MQTT.");
    Serial.println("RSSI data published to MQTT:\n" + mqtt_payload);
  }
}

void publishUWBData() {
  String mqtt_payload = "";
  for (int i = 0; i < detectedBeacons; i++) {
    if (!uwbdata[i].deviceName.isEmpty()) {
      mqtt_payload += uwbdata[i].deviceName + " : " + String(uwbdata[i].rangeValue) + "\n";
    }
  }
  if (!mqtt_payload.isEmpty()) {
    client.publish(mqtt_topic_uwb, mqtt_payload.c_str());
    Serial.println(mqtt_topic_uwb);
    Serial.println("Range data published to MQTT:\n" + mqtt_payload);
  }
}

void publishDetectedBeacons() {
  String mqtt_payload = String(detectedBeacons);
  client.publish(mqtt_topic_maxbeacon, mqtt_payload.c_str());
  Serial.println(mqtt_topic_maxbeacon);
  Serial.println("Number of detected beacons published to MQTT: " + mqtt_payload);
}

void newRange() {
  String deviceName = String(DW1000Ranging.getDistantDevice()->getShortAddress(), HEX);
  float rangeValue = DW1000Ranging.getDistantDevice()->getRange();
  int index = -1;
  for (int i = 0; i < detectedBeacons; i++) {
    if (uwbdata[i].deviceName == deviceName) {
      index = i;
      break;
    }
  }
  if (index == -1) {
    for (int i = 0; i < 50; i++) {
      if (uwbdata[i].deviceName.isEmpty()) {
        index = i;
        uwbdata[i].deviceName = deviceName;
        detectedBeacons++;
        publishDetectedBeacons();  // Publish the number of detected beacons
        break;
      }
    }
  }
  if (index != -1) {
    uwbdata[index].rangeValue = rangeValue;
  }
  Serial.print("from: ");
  Serial.print(DW1000Ranging.getDistantDevice()->getShortAddress(), HEX);
  Serial.print("\t Range: ");
  Serial.print(DW1000Ranging.getDistantDevice()->getRange());
  Serial.println(" m");
}

void newDevice(DW1000Device *device) {
  Serial.print("ranging init; 1 device added ! -> ");
  Serial.print(" short:");
  Serial.println(device->getShortAddress(), HEX);
}

void inactiveDevice(DW1000Device *device) {
  Serial.print("delete inactive device: ");
  Serial.println(device->getShortAddress(), HEX);
}

void setup() {
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);  // Set MQTT callback function
  reconnect();

  // Initialize BLE
  BLEDevice::init("Tag 1");
  pBLEScan = BLEDevice::getScan();
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
  pBLEScan->setActiveScan(true);
  pBLEScan->setInterval(10);
  pBLEScan->setWindow(9);

  // Initialize UWB
  SPI.begin(SPI_SCK, SPI_MISO, SPI_MOSI);
  DW1000Ranging.initCommunication(PIN_RST, DW_CS, PIN_IRQ);
  DW1000Ranging.attachNewRange(newRange);
  DW1000Ranging.attachNewDevice(newDevice);
  DW1000Ranging.attachInactiveDevice(inactiveDevice);
  DW1000Ranging.startAsTag(TAG_ADD, DW1000.MODE_LONGDATA_RANGE_LOWPOWER);
}

void callback(char* topic, byte* payload, unsigned int length) {
  String message;
  for (unsigned int i = 0; i < length; i++) {
    message += (char)payload[i];
  }
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  Serial.println(message);
  if (String(topic) == mqtt_topic_spb && message == "hello") {
    useBLE = false;
    uwbStartTime = millis();
    Serial.println("Switching to UWB mode for 2 minutes.");
  }
}

void loop() {
  if (!client.connected()) {
    reconnect();
    Serial.println("Clinet conne");
    Serial.println(client.connected());
  }
  client.loop();

  if (useBLE) {
    BLEScanResults foundDevices = pBLEScan->start(scanTime, false);
    pBLEScan->clearResults();

    unsigned long currentTime = millis();
    for (int i = 0; i < 50; i++) {
      if (rssiData[i].active && (currentTime - rssiData[i].lastSeen > beaconTimeout)) {
        rssiData[i].active = false;
        rssiData[i].deviceName = "";
        rssiData[i].rssiValue = 0;
        rssiData[i].filteredRssiValue = 0;
        detectedBeacons--; // Decrement the count of detected beacons
        publishDetectedBeacons();  // Publish the number of detected beacons
        Serial.println("Beacon " + String(i + 1) + " disconnected and removed.");
      }
    }
    if (currentTime - lastPublishTimeBLE >= publishIntervalBLE) {
      publishRSSIData();
      lastPublishTimeBLE = currentTime;
    }
  } else {
    DW1000Ranging.loop();

    unsigned long currentTime = millis();
    if (currentTime - lastPublishTimeUWB >= publishIntervalUWB) {
      publishUWBData();
      lastPublishTimeUWB = currentTime;
    }
    if (currentTime - uwbStartTime >= uwbDuration) {
      useBLE = true;
      Serial.println("Switching back to BLE mode.");
    }
  }
}
