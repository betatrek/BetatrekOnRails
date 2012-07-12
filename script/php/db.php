<?php
/************************************
 Connects to the database.
************************************/
function connect_to_database() {
    global $db_conn;
    $db_conn = pg_connect("host=localhost dbname=betatrek_production ".
                          "user=betatrek password=bettafishswimminginapool")
               or die('Could not connect: ' . pg_last_error());
}

/************************************** 
 Inserts the given asset into the database.
 @param $asset The given Asset object 
***************************************/                           
function insertAsset($asset) {
    global $db_conn;
    // Execute the insert with the given asset
    $result = pg_execute($db_conn, "insert-asset", array($asset->ticker, 
                         $asset->evaluation, $asset->volume, 
                         $asset->market_cap, $asset->beta));

    if ($result === false) {
       print "Error inserting asset " . pg_last_error();
    }
}

/*************************************
 Inserts the given historical asset into the database.
 @param $asset The given array of historical asset data 
               (date, ticker, open, high, low, close, volume, adjusted close)
**************************************/
function insertHistoricalAsset($asset) {
    global $db_conn;
    // Clear our results
    while (pg_get_result()) {}
    // Execute the insert with the given asset
    $result = pg_execute($db_conn, "insert-historical", $asset);

    if ($result === false) {
        print "Error inserting historical asset " . pg_last_error();
    }
}

/*************************************
 Closes the database connection.
**************************************/
function close_database_connection() { 
    global $db_conn;
    pg_close($db_conn); 
}

// Establish a connection
$db_conn;
connect_to_database();

// Clear our results
while (pg_get_result()) {}
// Prepare inserts for execution
pg_send_prepare($db_conn, "insert-asset", "INSERT INTO assets (ticker, evaluation, " .
                "volume, market_cap, beta) VALUES ($1, $2, $3, $4, $5)");
// Clear our results
while (pg_get_result()) {}
pg_send_prepare($db_conn, "insert-historical", "INSERT INTO assets (ticker, date, open, " .
                "high, low, close, volume, adjusted_close) " .
                "VALUES ($1, $2, $3, $4, $5, $6, $7, $8)");
?>