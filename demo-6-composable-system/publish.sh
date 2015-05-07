while true; do
  #mosquitto_pub -t openwest/pianos/1 -m 72 -h 192.168.1.104
  mosquitto_pub -t openwest/drums/1 -m 72 -h 192.168.1.104
  sleep 1
  mosquitto_pub -t openwest/drums/1 -m 69 -h 192.168.1.104
  sleep 1
done
