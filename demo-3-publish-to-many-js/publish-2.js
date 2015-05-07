var mqtt = require('mqtt');
var client = mqtt.connect('mqtt://localhost:1883');

client.on('connect', function () {
    client.publish(
      'openwest/demo3/publisher/2/status',
      JSON.stringify({'status' : 'ALERT', 'message' : 'UKNOWN ERROR'})
    );
  client.end();
});
