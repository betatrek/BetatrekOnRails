<?php
class Asset {
    public $ticker = null;
    public $evaluation = null;
    public $volume = null;
    public $mkt_cap = null;
    public $beta = null;

    function __construct() {
        $this->ticker = "INVALID";
        $this->evaluation = 0;
        $this->volume = 0;
        $this->mkt_cap = 0;
        $this->beta= 0;
    }

    public function setBeta($beta) { 
        $this->beta = $beta;
    }

    public function getBeta() { 
        return $this->beta;
    }
}
?>