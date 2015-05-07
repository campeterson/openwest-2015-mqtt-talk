require 'mqtt'
require 'lifx'

# Initialize stuff
@client = MQTT::Client.connect("mqtt://192.168.1.104:1883")
#@client = MQTT::Client.connect("mqtt://localhost:1883")
@lifx = LIFX::Client.lan
@lifx.discover!

sleep 2
puts @lifx.lights.map{|l| l.label}

@c_bulb = @lifx.lights.with_label("OpenWest-Color-LIFX")

# Flash light to say we're connected
if @c_bulb
  puts "Using light(s): #{@c_bulb}"
  5.times do
    @c_bulb.set_color(LIFX::Color.send("red"), duration: 0.1)
    sleep 0.3
    @c_bulb.set_color(LIFX::Color.send("blue"), duration: 0.1)
  end
else
  puts "Color LIFX not found"
  exit 1
end

# Handle the message
def process_message(topic, message)
  color = if message.to_i < 40
            "red"
          elsif message.to_i <= 62
            "green"
          elsif message.to_i <= 64
            "blue"
          elsif message.to_i <= 66
            "yellow"
          elsif message.to_i <= 69
            "orange"
          else
            "purple"
          end

  if @c_bulb && color # && topic.include?("piano")
    @c_bulb.set_color(LIFX::Color.send(color), duration: 0.1)
  end
end

# Subscribe
def subscribe(client, topic)
  client.get(topic) do |topic,message|
    puts "#{topic}: #{message}"
    process_message(topic, message)
  end
end

subscribe(@client, ['openwest/pianos/#', 'openwest/drums/#'])
