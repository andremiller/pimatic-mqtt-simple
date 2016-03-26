# #Plugin template

# This is an plugin template and mini tutorial for creating pimatic plugins. It will explain the 
# basics of how the plugin system works and how a plugin should look like.

# ##The plugin code

# Your plugin must export a single function, that takes one argument and returns a instance of
# your plugin class. The parameter is an envirement object containing all pimatic related functions
# and classes. See the [startup.coffee](http://sweetpi.de/pimatic/docs/startup.html) for details.
module.exports = (env) ->

  # ###require modules included in pimatic
  # To require modules that are included in pimatic use `env.require`. For available packages take 
  # a look at the dependencies section in pimatics package.json

  # Require the  bluebird promise library
  Promise = env.require 'bluebird'

  # Require the [cassert library](https://github.com/rhoot/cassert).
  assert = env.require 'cassert'

  # Include you own depencies with nodes global require function:
  #  
  #     someThing = require 'someThing'
  #
  
  # Require the mqtt library
  mqtt = require 'mqtt'

  # ###MyPlugin class
  # Create a class that extends the Plugin class and implements the following functions:
  class MqttSimplePlugin extends env.plugins.Plugin

    # ####init()
    # The `init` function is called by the framework to ask your plugin to initialise.
    #  
    # #####params:
    #  * `app` is the [express] instance the framework is using.
    #  * `framework` the framework itself
    #  * `config` the properties the user specified as config for your plugin in the `plugins` 
    #     section of the config.json file 
    #     
    # 
    init: (app, @framework, @config) =>
      deviceConfigDef = require("./device-config-schema")

      @framework.deviceManager.registerDeviceClass("MqttSimpleSensor", {
        configDef: deviceConfigDef.MqttSimpleSensor,
        createCallback: (config) => return new MqttSimpleSensor(config)
      })

      @framework.deviceManager.registerDeviceClass("MqttSimpleSwitch", {
        configDef: deviceConfigDef.MqttSimpleSwitch,
        createCallback: (config, lastState) => return new MqttSimpleSwitch(config, lastState)
      })

  class MqttSimpleSensor extends env.devices.Sensor
    constructor: (@config) ->
      @name = config.name
      @id = config.id

      @attributes = {}
      @mqttvars = []

      mqttclient = mqtt.connect(config.mqtturl, {
        protocolId: 'MQIsdp',
        protocolVersion: 3
      })

      mqttclient.on('error', (error) => 
        console.log("MQTT Error: " + error.toString());
      )
       
      mqttclient.on('connect', =>
        #console.log("Connected")
        # Subscribe to the topics
        for attr, i in @config.attributes
          do (attr) =>
            mqttclient.subscribe(attr.topic)
      )
       
      mqttclient.on('message', (topic, message) => 
        # message is Buffer
        # Get the right name for this topic
        for attr, i in @config.attributes
          do (attr) =>
            if attr.topic == topic
              # Update value in local array
              #console.log(topic + ": " + message.toString())
              @mqttvars[topic] = message.toString()
              # Emit the new value
              try data = JSON.parse(message)
              if data?
                if data then for key, value of data
                  if key == attr.name
                    if attr.type == 'number'
                      if attr.division
                        @emit attr.name, Number("#{value}") / attr.division
                      else
                        @emit attr.name, Number("#{value}")
                    else
                      @emit "#{key}: #{value}"
                else
                  if attr.type == 'number'
                    if attr.division
                      @emit attr.name, Number(message) / attr.division
                    else
                      @emit attr.name, Number(message)
                  else
                    @emit attr.name, message.toString()
      )

      for attr, i in @config.attributes
        do (attr) =>
          name = attr.name
          @attributes[name] = {
            description: name
          }

          @attributes[name].description = name
          @attributes[name].type = attr.type
          @attributes[name].unit = attr.unit or ''
          @attributes[name].discrete = attr.discrete or false
          @attributes[name].acronym = attr.acronym or null
          @attributes[name].division = attr.division or 1

          getter = ( =>
            if attr.type == 'number'
              value = Number(@mqttvars[attr.topic])
            else
              value = @mqttvars[attr.topic]
            Promise.resolve(value)
          )

          @_createGetter(name, getter)

      super()

  class MqttSimpleSwitch extends env.devices.PowerSwitch

    mqttclient = null

    constructor: (@config, @lastState) ->
      @name = config.name
      @id = config.id
      @_state = lastState?.state?.value or off

      mqttclient = mqtt.connect(config.mqtturl, {
        protocolId: 'MQIsdp',
        protocolVersion: 3
      })

      mqttclient.on('error', (error) =>
        console.log("MQTT Error: " + error.toString());
      )

      mqttclient.on('connect', =>
        if config.stateTopic == ""
          mqttclient.subscribe(config.topic)
        else
          mqttclient.subscribe(config.stateTopic)
      )

      mqttclient.on('message', (topic, message) =>
        switch message.toString()
          when "on", "true", "1", "t", "o"
            @_setState(on)
            @_state = on
            @emit @name, on
          else
            @_setState(off)
            @_state = off
            @emit @name, off
      )
      super()

    changeStateTo: (state) ->

      #if @state is state then return
      # and execute it.
      message = (if state then @config.onMessage else @config.offMessage)
      mqttclient.publish(@config.topic, message)

      @_setState(state)
      return

  # ###Finally
  # Create a instance of my plugin
  mqttSimplePlugin = new MqttSimplePlugin
  # and return it to the framework.
  return mqttSimplePlugin
