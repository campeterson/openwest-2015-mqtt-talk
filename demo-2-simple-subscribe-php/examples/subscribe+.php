<?php

require("../phpMQTT.php");

	
$mqtt = new phpMQTT("localhost", 1883, "DEMO-1-Subscriber");

if(!$mqtt->connect()){
	exit(1);
}

$topics['openwest/+/status'] = array("qos"=>0, "function"=>"procmsg");
$mqtt->subscribe($topics, 0);

while($mqtt->proc()){
		
}

$mqtt->close();

function procmsg($topic,$msg){
  echo "{$topic} | $msg\n";
}

?>
