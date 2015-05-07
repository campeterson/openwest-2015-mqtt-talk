(ns mqtt-musical.core
  (:gen-class)
  (:require [clojurewerkz.machine-head.client :as mh]))

(defn handle-delivery
  [^String topic _ ^bytes payload]
  (let [msg (String. payload "UTF-8")]
    (println (str topic " | " msg))))

(comment
  ;(def conn (mh/connect "tcp://localhost:1883" (mh/generate-id)))
  (def conn (mh/connect "tcp://192.168.1.104" (mh/generate-id)))

  (mh/subscribe conn ["openwest/#"] handle-delivery)

  (mh/publish conn "openwest/arduinos/1/popcorn" "ON")
  (mh/publish conn "openwest/arduinos/1/popcorn" "OFF")
  
  )
