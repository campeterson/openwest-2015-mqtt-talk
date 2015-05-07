(ns mqtt-musical.core
  (:use [overtone.live]
        [overtone.inst.drum] 
        [overtone.inst.piano] 
        [overtone.inst.synth])
  (:gen-class)
  (:require [clojurewerkz.machine-head.client :as mh]))

(defn handle-delivery
  [^String topic _ ^bytes payload]
  (let [num (Integer. (String. payload "UTF-8"))]
    (println num)
    (cond
      (some? (re-seq #"piano" topic)) (piano num)
      (some? (re-seq #"drums" topic)) (kick num))))

#_(piano 70)
#_(piano 69)
#_(piano 66)
#_(piano 64)
#_(piano 62)
#_(kick 62)

;(def conn (mh/connect "tcp://localhost:1883" (mh/generate-id)))

#_(def conn (mh/connect "tcp://192.168.1.104" (mh/generate-id)))

#_(mh/subscribe conn ["openwest/#"] handle-delivery)

