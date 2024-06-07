#include <BLEDevice.h>
#include <BLEServer.h>
#include <SPI.h>
#include "DW1000Ranging.h"
#include "DW1000.h"

// BLE configuration
#define SERVICE_UUID "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

BLEServer *pServer;
BLECharacteristic *pCharacteristic;

// UWB configuration
#define ANCHOR_ADD "02:00:5B:D5:A9:9A:E2:9C"

#define SPI_SCK 18
#define SPI_MISO 19
#define SPI_MOSI 23
#define DW_CS 4

// Connection pins
const uint8_t PIN_RST = 27; // reset pin
const uint8_t PIN_IRQ = 34; // irq pin
const uint8_t PIN_SS = 4;   // spi select pin

float this_anchor_target_distance = 1.0; // measured distance to anchor in meters
uint16_t this_anchor_Adelay = 16610; // starting value
uint16_t Adelay_delta = 100; // initial binary search step size
bool kalibrasi_selesai = false;

void newRange() {
    static float last_delta = 0.0;
    float dist = 0;

    if (!kalibrasi_selesai) {
        for (int i = 0; i < 10; i++) {
            // Get and average 100 measurements
            dist += DW1000Ranging.getDistantDevice()->getRange();
        }
        dist /= 10.0;

        Serial.print(DW1000Ranging.getDistantDevice()->getShortAddress(), DEC);
        Serial.print(",");
        Serial.print(dist);

        if (Adelay_delta < 2) {
            Serial.print(", final Adelay: ");
            Serial.println(this_anchor_Adelay);
            kalibrasi_selesai = true;

            // Apply the calibrated Adelay
            DW1000.setAntennaDelay(this_anchor_Adelay);
        } else {
            float this_delta = dist - this_anchor_target_distance; // error in measured distance

            if (this_delta * last_delta < 0.0) {
                Adelay_delta /= 2; // reduce step size if sign changed
            }
            last_delta = this_delta;

            if (this_delta > 0.0) {
                this_anchor_Adelay += Adelay_delta; // new trial Adelay
            } else {
                this_anchor_Adelay -= Adelay_delta;
            }

            Serial.print(", Adelay = ");
            Serial.println(this_anchor_Adelay);
            DW1000.setAntennaDelay(this_anchor_Adelay);
        }
    } else {
        #define NUMBER_OF_DISTANCES 1
        float measured_dist = 0.0;
        for (int i = 0; i < NUMBER_OF_DISTANCES; i++) {
            measured_dist += DW1000Ranging.getDistantDevice()->getRange();
        }
        measured_dist /= NUMBER_OF_DISTANCES;

        Serial.print("from: ");
        Serial.print(DW1000Ranging.getDistantDevice()->getShortAddress(), HEX);
        Serial.print(", ");
        Serial.print(measured_dist);
        Serial.println(" m");
    }
}

void newBlink(DW1000Device *device) {
    Serial.print("blink; 1 device added! -> ");
    Serial.print(" short:");
    Serial.println(device->getShortAddress(), HEX);
}

void inactiveDevice(DW1000Device *device) {
    Serial.print("delete inactive device: ");
    Serial.println(device->getShortAddress(), HEX);
}

void setup() {
    Serial.begin(115200);
    delay(1000);

    // BLE setup
    Serial.println("Starting BLE work!");
    BLEDevice::init("Beacon 2");
    pServer = BLEDevice::createServer();
    BLEService *pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(
        CHARACTERISTIC_UUID,
        BLECharacteristic::PROPERTY_READ |
        BLECharacteristic::PROPERTY_WRITE
    );
    pCharacteristic->setValue("Beacon 2");
    pService->start();
    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->setScanResponse(true);
    BLEDevice::startAdvertising();
    Serial.println("Characteristic defined!");

    // UWB setup
    SPI.begin(SPI_SCK, SPI_MISO, SPI_MOSI);
    DW1000Ranging.initCommunication(PIN_RST, PIN_SS, PIN_IRQ); // Reset, CS, IRQ pin

    Serial.print("Starting Adelay: ");
    Serial.println(this_anchor_Adelay);
    Serial.print("Measured distance: ");
    Serial.println(this_anchor_target_distance);

    DW1000.setAntennaDelay(this_anchor_Adelay);
    DW1000Ranging.attachNewRange(newRange);
    DW1000Ranging.attachBlinkDevice(newBlink);
//    DW1000Ranging.attachInactiveDevice(inactiveDevice);

    // Start the module as anchor
    DW1000Ranging.startAsAnchor(ANCHOR_ADD, DW1000.MODE_LONGDATA_RANGE_LOWPOWER, false);
    DW1000Ranging.useRangeFilter(true);
}

void loop() {
    // BLE loop
    // No additional code needed for BLE in the loop

    // UWB loop
    DW1000Ranging.loop();
}
