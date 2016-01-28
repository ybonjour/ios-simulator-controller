module IosSimulatorController
	class Simulator
		attr_reader :runtime

		def initialize(runtime, simulator_string, instruments=Tools::Instruments.new)
			@runtime = runtime
			@simulator_string = simulator_string
			@instruments = instruments
		end

		def id
			/.*\((.*)\) \(.*\)/.match(simulator_string).captures.first
		end

		def start
			instruments.launch_simulator(id)
		end

		private
		attr_reader :simulator_string, :instruments
	end
end