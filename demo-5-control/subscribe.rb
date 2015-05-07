require 'mqtt'

#client = MQTT::Client.connect("mqtt://localhost:1883")
client = MQTT::Client.connect("mqtt://192.168.1.104:1883")

# Subscribe
client.get('openwest/#') do |topic,message|
  puts "#{topic} | #{message}"
end
