<?php
include('simple_html_dom.php');
include_once 'asset.php';
include_once 'db.php';

/************************************
 Retrieves the Google Finance data for the given ticker and stores it in the
 asset database.
 @param $ticker the given String ticker symbol 
 ************************************/
function getGoogleTickerData($ticker) {
    $asset = new Asset();

    $url = "http://www.google.com/finance?q=".$ticker;
    $gf_page = "data/".$ticker."_gf.html";

    print "$url\n";
    /* Get the data from google finance */
    system("curl --silent -o $gf_page \"$url\"");

    // Create HTML DOM object 
    $html = file_get_html($gf_page);

    // Extract the required data 
    // Find the information tables
    $snap_data0 = $html->find('table.snap-data', 0);
    $snap_data1 = $html->find('table.snap-data', 1);
    
    // Print these tables
    if (is_object($snap_data0)) {
        foreach($snap_data0->find('tr') as $row) {
            print "\n";

            foreach($row->find('td') as $cell) {
                // push the cell's text to the array
                print "$cell->innertext";
            }

            $row_data = $row->find('td', 1);
            print $row_data->innertext;
        }
        print "\n";
    } else { return; }

    if (is_object($snap_data1)) {
        foreach($snap_data1->find('tr') as $row) {
            print "\n";

            foreach($row->find('td') as $cell) {
                // push the cell's text to the array
                print "$cell->innertext";
            }

            $row_data = $row->find('td', 1);
            print $row_data->innertext;
        }
        print "\n";
        print "\n";
    } else { return; }

    // Find the current evaluation
    $current_evaluation = $html->find('span[class=pr]', 0)->plaintext;

    // Extract snapdata 
    $range = $snap_data0->find('tr', 0)->find('td', 1)->plaintext;
    $range_52 = $snap_data0->find('tr', 1)->find('td', 1)->plaintext;
    $open = $snap_data0->find('tr', 2)->find('td', 1)->plaintext;
    $volume = $snap_data0->find('tr', 3)->find('td', 1)->plaintext;
    $mkt_cap = $snap_data0->find('tr', 4)->find('td', 1)->plaintext;
    $PE = $snap_data0->find('tr', 5)->find('td', 1)->plaintext;

    $div_yield = $snap_data1->find('tr', 0)->find('td', 1)->plaintext;
    $EPS = $snap_data1->find('tr', 1)->find('td', 1)->plaintext;
    $shares = $snap_data1->find('tr', 2)->find('td', 1)->plaintext;
    $beta = $snap_data1->find('tr', 3)->find('td', 1)->plaintext;
    $inst_own = $snap_data1->find('tr', 4)->find('td', 1)->plaintext;

    /* Insert the data into database. */
    $asset->ticker = $ticker;
    $asset->evaluation = floatval($current_evaluation);
    $asset->volume = intval($volume);
    $asset->mkt_cap = intval($mkt_cap);
    $asset->beta = floatval($beta);
    insertAsset($asset);
}

/************************************
 Retrieves the Yahoo Finance data for the given ticker and stores it in the
 asset database.
 @param $ticker the given String ticker symbol 
 ************************************/
function getYahooTickerData($ticker) {
    $url = "http://ichart.finance.yahoo.com/table.csv?s=" . $ticker .
           "&d=" . date("n")-1 . "&e=" . date("d") . "&f=" . date("Y") . 
           "&g=d&a=7&b=19&c=2004&ignore=.csv";
    $yf_page = "data/" . $ticker . "_yf.csv";

    print "$url\n";
    /* Gt the data from google finance */
    system("curl --silent -o $yf_page \"$url\"");

    // Create CSV object
    if ($fh = fopen($yf_page, "r")) {
        while (!feof($file_handle)) {
            $line = fgets($file_handle);
            list($date,$open,$high,$low,$close,$volume,$adjusted_close) = 
                                                                 $asset = explode(',', 
                                                                                  $line);
            insertHistoricalAsset($asset);
        }
        fclose($fh);
    }
}
?>