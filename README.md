pimatic-mqtt-simple
===================

A very basic mqtt plugin for [Pimatic](http://www.pimatic.org/)

Installation
------------
Edit your config.json as below, and once you restart pimatic the plugin will be downloaded automatically from npm.


Usage
-----
In your plugins section of pimatic's config.json file add:

    {
      "plugin": "mqtt-simple"
    }

In the devices section:

    {
      "class": "MqttSimpleSensor",
      "id": "powerusage",
      "name": "Power Usage",
      "mqtturl": "mqtt://localhost",
      "attributes": [
        {
          "name": "PowerUsage",
          "topic": "power/usage",
          "type": "number",
          "unit": "W",
          "acronym": "P.Usage"
        }
      ]
    }
   
