<?php
header("Content-Type:text/html; charset=utf-8");

echo '<h2>NIDS System Info: <a href="./6JFh5bD3wSLs7QH3.log" target="_new">Check</a></h2>';
echo '<h2>NIDS Rule Status: <a href="./3Bf87JkU3WeS35Nc.log" target="_new">Check</a></h2>';

$data_raw=shell_exec("cat /var/www/html/A2YR5bXP3d8kg9Sc.log");
$data_string=explode(",", $data_raw);
echo '<h2>NIDS System Status: <a href="./mrtg" target="_new">Check</a></h2>';
echo "System CPU Utilization: $data_string[0]<br>";
echo "System Memory Utilization: $data_string[1]<br>";
echo "Sniffer-NIC Inbound Traffic: $data_string[2]<br>";
echo "Sniffer-NIC Inbound Packet: $data_string[3]<br>";
echo "Sniffer-NIC Drop Packet: $data_string[4]<br>";
echo "Enabled Threads: $data_string[5]<br>";
echo "<br>";

$ip = $_SERVER['REMOTE_ADDR'];
echo "<h2>Hello, $ip ! (";
echo date("Y-m-d h:i:s A");
echo ")</h2>";

echo "<h2>This is an IDS log station for example.com. <b><u>All public use is prohibited.</u></b> </h2>";
echo "<br>";
echo "<h2>You may want to...</h2>";
echo '<h4>(0) <a href="./README.md" target="_new">Read Development Journal</a></h4>';
echo "<h4>(1) <a href='./full/'>Get FULL logs</a></h4>";
echo "<h4>(2) <a href='./arch/'>Get ARCHIVED logs</a> (recommended)</h4>";
echo "<h4>(3) <a href='./blacklist/'>Find suspicious IPs of NCKUEE in daily report</a></h4>";
echo "<h4>NOTE: Please do NOT try to open the FULL log via your browser, the browser may be stuck due to the file size.</h4>";
echo "<br><hr><center><font face=\"calibri\" size=\"3\">";
echo "Website is maintained by <b>admin</b> [eight] example.org, utilizing for <b>ANY</b> publications please let me know first.";
echo "<br>Copyright © 2016-";
echo date("Y");
echo " ";
echo "MIT License, Project ";
echo '<a href="https://github.com/pwtsai/snort-fairy" target="_new">((snort-fairy)</a>';
echo "</center></font>";
?>

