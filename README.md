# iOS Simulator Controller
A ruby gem to programatically control iOS Simulators.

# How to use it
```
require 'ios-simulator-controller'

simulator_selector = IosSimulatorController::SimulatorSelector.new

simulator = simulator_selector('iOS 8.1', 'iPhone 5')

application = IosSimulatorController::Application.new

simulator.start
simulator.install(application)
simulator.launch(application)
simulator.close(application)
simulator.uninstall(application)
simulator.stop
```

# Authors
Slawomir Smiechura, Brigit Lyons, Yves Bonjour