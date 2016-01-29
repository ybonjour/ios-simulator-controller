# iOS Simulator Controller
A ruby gem to programatically control iOS Simulators.

# How to use it
```ruby
require 'ios-simulator-controller'

simulator_selector = IosSimulatorController::SimulatorSelector.new

simulator = simulator_selector.select('iOS 8.1', 'iPhone 5')

application = IosSimulatorController::Application.new('/path/to/YourApplication.appgit')

simulator.start
simulator.install(application)
simulator.launch(application)
simulator.close(application)
simulator.uninstall(application)
simulator.stop
simulator.erase_contents_and_settings
```

# Authors
Slawomir Smiechura, Brigit Lyons, Yves Bonjour
