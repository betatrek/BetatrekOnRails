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
    // Execute the insert with the given asset
    $result = pg_execute($db_conn, "insert", array($asset->ticker, 
                         $asset->evaluation, $asset->volume, 
                         $asset->market_cap, $asset->beta));

    if ($result === false) {
       print "Error inserting asset" . pg_last_error();
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

// Prepare a insert for execution
pg_send_prepare($db_conn, "insert", "INSERT INTO assets (ticker, evaluation, volume, ". 
                "market_cap, beta) VALUES ($1, $2, $3, $4, $5)");
?>