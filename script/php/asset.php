<?php
class Asset {
    public $ticker = null;
    public $evaluation = null;
    public $volume = null;
    public $market_cap = null;
    public $beta = null;

    function __construct() {
        $this->ticker = "INVALID";
        $this->evaluation = 0;
        $this->volume = 0;
        $this->market_cap = 0;
        $this->beta = 0;
    }
}
?>