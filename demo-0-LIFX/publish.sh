while true; do
  #mosquitto_pub -t openwest/instrument/2 -m "########## Bass ##########"
  mosquitto_pub -t openwest/lights/color-LIFX -m "white" -h 192.168.1.104
  sleep 1
  mosquitto_pub -t openwest/lights/color-LIFX -m "blue" -h 192.168.1.104
  sleep 1
done
