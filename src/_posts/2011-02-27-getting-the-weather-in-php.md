---
layout: post
title: Getting the Weather in PHP
description: 'How to use a secret google API to get the weather.'
---
A few months ago I made a small PHP class which can get the weather based on latitude and longitude.

Here is a code example of how to get the weather:


```php
<?php

include('weather-class.inc.php'); // This has all the code.

$w = new Weather('50.799995', '-1.065545'); // Input the Latitude and Longitude
echo $w->getLocation()->getWeather()->sayHuman();
// Output: Portsmouth, England, PO4 8 | Partly Cloudy 4°C, Humidity: 93%, Wind: N at 8 mph

?>
```

Here is the class file to make it all work:

```php
<?php
class Weather {
  public $lat, $long, $weather, $location;
  private $weather_data, $location_data;
  
  public function __construct($lat=0.0, $long=0.0){
    $this->lat = (float) $lat;
    $this->long = (float) $long;
  }
  
  // Find out the local weather
  public function getWeather(){
    // Load the Weather data
    $this->weather_data = simplexml_load_file(
      'http://www.google.com/ig/api?weather=,,,'.(int)($this->lat*1000000).','.(int)($this->long*1000000));
      
    //var_dump($this->weather_data->weather);
    $this->weather['condition'] = (string)$this->weather_data->weather->current_conditions->condition["data"];
    $this->weather['temp_c'] = (int)$this->weather_data->weather->current_conditions->temp_c["data"];
    $this->weather['humidity'] = (string)$this->weather_data->weather->current_conditions->humidity["data"];
    $this->weather['wind_condition'] = (string)$this->weather_data->weather->current_conditions->wind_condition["data"];
    return $this;
  }
  
  // Get the nearest weather hub location
  public function getLocation(){
    // Load the location data
    $this->location_data = simplexml_load_file(
    'http://maps.google.com/maps/api/geocode/xml?sensor=true&latlng='.($this->lat).','.($this->long));
    
    // Set the name based on the location. e.g: Portsmouth, England
    $this->location = $this->location_data->result->address_component[2]->short_name.', '.$this->location_data->result->address_component[4]->short_name.', '.$this->location_data->result->address_component[6]->short_name;
    return $this;
  }
  
  public function sayHuman(){
    return $this->location.' | '.
    $this->weather['condition'].' '.
    $this->weather['temp_c'].'°C, '.
    $this->weather['humidity'].', '.
    $this->weather['wind_condition'];
  }
  
}

// Example
$w = new Weather('50.799995', '-1.065545'); // Input the Latitude and Longitude
echo $w->getLocation()->getWeather()->sayHuman();
// Output: Portsmouth, England, PO4 8 | Partly Cloudy 4°C, Humidity: 93%, Wind: N at 8 mph
?>
```

Enjoy!
