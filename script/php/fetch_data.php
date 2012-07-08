<?php
include_once './include/user.php';
include_once './include/ticker.php';
include './include/getWebData.php';

$nasdaq_file = "TKR_NASDAQ";
$lines = split("\n", file_get_contents($nasdaq_file));

foreach($lines as $line_num => $line) {
    echo $line;
    getGoogleTickerData($line);
}
?>