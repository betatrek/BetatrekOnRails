#!/usr/bin/php
<?php
include_once 'user.php';
include_once 'ticker.php';
include 'getWebData.php';

$nasdaq_file = "TKR_NASDAQ";
$lines = split("\n", file_get_contents($nasdaq_file));

foreach($lines as $line_num => $line) {
    echo $line;
    getGoogleTickerData($line);
}
?>