var mqtt = require('mqtt');
var client = mqtt.connect('mqtt://localhost:1883');

client.on('connect', function () {
  client.publish(
    'openwest/demo3/publisher/1/status',
    JSON.stringify({ 'status' : 'OK', 'message' : '' })
  );
  client.end();
});
