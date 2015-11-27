# #my-plugin configuration options
# Declare your config option for your plugin here. 
module.exports = {
  title: "MqttSimpleSensor/Switch device config schema"
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
  MqttSimpleSwitch: {
    title: "MqttSimpleSwitch config options"
    type: "object"
    properties:
      mqtturl:
        description: "MQTT Server URL, for example mqtt://localhost"
        type: "string"
      topic:
        description: "Topic to control switch"
        type: "string"
      onMessage:
        description: "Message to switch on"
        type: "string"
        default: "on"
      offMessage:
        description: "Message to switch off"
        type: "string"
        default: "off"
      stateTopic:
        description: "Topic that communicates state"
        type: "string"
        default: ""
  }
}
