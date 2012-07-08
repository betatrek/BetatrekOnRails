<?php
/************************************
 Connects to the database.
 @return the established connection to the underlying database.
************************************/
function connect_to_database() {
    $db_conn = pg_connect("host=localhost dbname=betatrek_production".
                          "user=betatrek password=bettafishswimminginapool")
               or die('Could not connect: ' . pg_last_error());

    return $db_conn;
}

/************************************** 
 Inserts the given asset into the database.
 @param asset The given Asset object 
 ***************************************/                           
public function insertAsset($asset) {
    $db_conn = connect_to_database();

    // Prepare a insert for execution
    $result = pg_prepare($db_conn, "insert", "INSERT INTO Asset (ticker, ".
                         " evaluation, volume, market_cap, beta) VALUES ($1,".
                         "$2,$3,$4,$5)");

    // Execute the insert with the given asset
    $result = pg_execute($db_conn, "insert", array($asset->ticker, 
                         $asset->evaluation, $asset->volume, 
                         $asset->market_cap, $asset->beta));

    if ($result === false) {
       print "Error inserting Asset" . pg_last_error();
    }
    
    // Closes the connection
    pg_close($dbconn);
}
?>