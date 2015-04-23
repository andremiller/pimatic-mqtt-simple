# #my-plugin configuration options
# Declare your config option for your plugin here. 
module.exports = {
  title: "MqttSimpleSensor device config schema"
  MqttSimpleSensor: {
    title: "MqttSimpleSensor config options"
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