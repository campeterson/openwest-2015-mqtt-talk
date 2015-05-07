/*
  http://knolleary.net/arduino-client-for-mqtt/
  http://m2mio.tumblr.com/post/30048662088/a-simple-example-arduino-mqtt-m2m-io
*/

#include <SPI.h>
#include <Ethernet.h>
#include <PubSubClient.h>

// Update these with values suitable for your network.
byte mac[] = { 0x90, 0xA2, 0xDA, 0x00, 0x17, 0x1C };

EthernetClient ethClient;
PubSubClient client("192.168.1.104", 1883, callback, ethClient);

char message_buff[100];

void setup() {
  pinMode(5, OUTPUT);   // initialize digital pin 10 as an output.
  pinMode(4, OUTPUT);   // Output for Popcorn 
  digitalWrite(4, LOW); // Turn Popcorn OFF
  digitalWrite(5, LOW); // Turn it OFF

  Serial.begin(9600);
  if (Ethernet.begin(mac) == 0) {
    Serial.println("DHCP Failed to configure");
    return;
  }

  if (client.connect("openwest-mqtt-arduino", "arduino", "b2cfa4183267af678ea06c7407d4d6d8")) {
    client.publish("openwest/arduinos/1/status", "Hello OpenWest (from Arduino)!");
    client.subscribe("openwest/arduinos/1/#");
  }
}

void loop() {
  client.loop();
}

// Callback function
void callback(char* topic, byte* payload, unsigned int length) {
  int p = 0;
  // create character buffer with ending null terminator (string)
  for (p = 0; p < length; p++) {
    message_buff[p] = payload[p];
  }
  message_buff[p] = '\0';
  String msgString = String(message_buff);
  
  
  Serial.println("Message arrived:  topic: " + String(topic));
  Serial.println("Length: " + String(length, DEC));
  Serial.println("Message: " + msgString);

  char ledTopic[100];
  strcpy(ledTopic, topic);

  if (String(ledTopic) == "openwest/arduinos/1/popcorn") {
    if (msgString == "ON") {
      digitalWrite(4, HIGH); // Popcorn
      digitalWrite(5, HIGH); // LED
      client.publish("openwest/arduinos/1/status", "Turning ON Popcorn");
      //Serial.println("Turning ON Popcorn");
    } else if (msgString == "OFF") {
      digitalWrite(4, LOW); // Popcorn
      digitalWrite(5, LOW); // LED
      client.publish("openwest/arduinos/1/status", "Turning OFF Popcorn");
      //Serial.println("Turning OFF Popcorn");
    } else {
      Serial.println("msgString not matching");
      delay(1000);
    }
  } else {
    Serial.print("No Match|");
    Serial.print(topic);
    Serial.print("|\n");
  }
}
