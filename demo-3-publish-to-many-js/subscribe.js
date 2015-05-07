var mqtt = require('mqtt');
var client = mqtt.connect('tcp://localhost:1883');

client.on('connect', function () {
  client.subscribe('openwest/demo3/publisher/+/status');
});

client.on('message', function (topic, message) {
  // message is Buffer
  msg_obj = JSON.parse(message.toString());

  console.log(topic);
  console.log('Status: ' + msg_obj['status']);
  console.log('Message: ' + msg_obj['message']);
});
