require 'mqtt'

#client = MQTT::Client.connect(host: 'localhost', port: 1883)
client = MQTT::Client.connect(host: '192.168.1.104', port: 1883)

tune_notes = [66, 64, 62, 64, 66, 66, 66, 24, 64, 64, 64, 24, 66, 69, 69, 24, 66, 64, 62, 64, 66, 66, 66, 66, 64, 64, 66, 64, 62, 24]

tune_notes.each do |note|
  client.publish('openwest/pianos/1', note)
  puts "Published #{note} to openwest/pianos/1"
  sleep(0.5)
end
