<?php

require("../phpMQTT.php");

	
$mqtt = new phpMQTT("localhost", 1883, "DEMO-1-Publisher");

if ($mqtt->connect()) {
	$mqtt->publish("openwest/demo2/status", json_encode(array('status' => 'okay')), 0);
	$mqtt->publish("openwest/demo2/messages", "Did you notice I can send JSON?", 0);
  $mqtt->publish(
    "openwest/system/status", json_encode(array('status' => 'ALERT', 'message' => 'HDD is 90% Full')), 0);
	$mqtt->close();
}

?>
