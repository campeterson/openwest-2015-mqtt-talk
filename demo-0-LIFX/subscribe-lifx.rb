require 'mqtt'
require 'lifx'

ALLOWED_COLORS = ["red", "blue", "yellow", "orange", "green", "white", "purple"]

# Initialize stuff
@client = MQTT::Client.connect("mqtt://192.168.1.104:1883")
#@client = MQTT::Client.connect("mqtt://localhost:1883")
@lifx = LIFX::Client.lan
@lifx.discover!

sleep 2
puts @lifx.lights.map{|l| l.label}

@bulb = @lifx.lights.with_label("OpenWest-Color-LIFX")
#@bulb = @lifx.lights.first

# Flash light to say we're connected
if @bulb
  puts "Using light(s): #{@bulb}"
  5.times do
    @bulb.set_color(LIFX::Color.send("red"), duration: 0.1)
    sleep 0.3
    @bulb.set_color(LIFX::Color.send("blue"), duration: 0.1)
  end
else
  puts "Color LIFX not found"
  exit 1
end

# Handle the message
def process_message(topic, message)
  if ALLOWED_COLORS.include?(message)
    @bulb.set_color(LIFX::Color.send(message), duration: 0.2)
  end
end

# Subscribe
def subscribe(client, topic)
  client.get(topic) do |topic,message|
    puts "#{topic}: #{message}"
    process_message(topic, message)
  end
end

subscribe(@client, 'openwest/lights/color-LIFX')
