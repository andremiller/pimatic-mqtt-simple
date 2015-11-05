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
   
Also Accepts JSON MQTT message if the device is like this

    {
        "class": "MqttSimpleSensor",
        "id": "weatherstation",
        "name": "Weather Station",
        "mqtturl": "mqtt://localhost",
        "attributes": [
            {
                "name": "temp_in_c",
                "topic": "weatherstation",
                "type": "number",
                "unit": "c",
                "acronym": "Inside Temperature"
                },
            {
            "name": "temp_out_c",
            "topic": "weatherstation",
            "type": "number",
            "unit": "c",
            "acronym": "Outside Temperature"
            }
        ]
    }

Sample mqtt message
{"rel_pressue": "30.5015", "wind_ave": "0.00", "rain": "0", "rainin": "0", "hum_in": "64", "temp_in_f": "66.4", "dailyrainin": "0", "wind_dir": "225", "temp_in_c": "19.1", "hum_out": "81", "dailyrain": "0", "wind_gust": "0.00", "idx": "2015-10-22 21:41:03", "temp_out_f": "49.6", "temp_out_c": "9.8"}
