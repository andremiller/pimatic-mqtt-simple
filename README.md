pimatic-mqtt-simple
===================

A very basic mqtt plugin for [Pimatic](http://www.pimatic.org/)

Installation
------------
Clone this repository into your pimatic-app/node_modules (so you end up with pimatic-app/node_modules/pimatic-mqtt-simple/package.json)

In the pimatic-mqtt-simple directory run:
`npm install`

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
   
