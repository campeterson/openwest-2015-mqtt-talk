require 'mqtt'

#client = MQTT::Client.connect(host: 'localhost', port: 1883)
client = MQTT::Client.connect(host: '192.168.1.104', port: 1883)

loop do
  client.publish('openwest/drums/1', 50)
  puts "Published '50' to openwest/drums/1"

  sleep(2)
end
