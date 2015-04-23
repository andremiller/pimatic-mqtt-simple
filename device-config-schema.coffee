# #my-plugin configuration options
# Declare your config option for your plugin here. 
module.exports = {
  title: "MqttSensor device config schema"
  MqttSensor: {
    title: "MqttSensor config options"
    type: "object"
    properties:
      mqtturl:
        description: "MQTT Server URL, for example mqtt://localhost"
        type: "string"
      attributes:
        description: "Attributes of device"
        type: "array"
  }
}