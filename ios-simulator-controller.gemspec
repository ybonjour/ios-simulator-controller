Gem::Specification.new do |s|
  s.name        = 'ios-simulator-gemspec'
  s.version     = '0.0.1'
  s.date        = '2015-01-28'
  s.summary     = "A gem to programatically control iOS Simulators."
  s.description = "A ruby gem to programatically control iOS Simulators."
  s.authors     = ["Yves Bonjour", "Slwaomir Smiechura", "Brigit Lyons"]
  s.email       = 'yves.bonjour@gmail.com'
  s.files       = ["lib/ios_simulator_controller.rb"]
  s.homepage    = "https://github.com/ybonjour/ios-simulator-controller"
  s.license     = 'MIT'


  s.add_development_dependency 'rspec'

  s.add_dependency 'CFPropertyList'
end