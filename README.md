pimatic-andremiller-mqtt
========================

A very basic mqtt plugin for [Pimatic](http://www.pimatic.org/)

Installation
------------
Clone this repository into your pimatic-app/node_modules (so you end up with pimatic-app/node_modules/pimatic-andremiller-mqtt/package.json)

In the pimatic-andremiller-mqtt directory run:
`npm install`

Usage
-----
In your plugins section of pimatic's config.json file add:

    {
      "plugin": "andremiller-mqtt"
    }

In the devices section:

    {
      "class": "MqttSensor",
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
   
