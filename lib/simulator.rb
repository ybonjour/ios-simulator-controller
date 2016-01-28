module IosSimulatorController
	class Simulator
		attr_reader :runtime

		def initialize(runtime, simulator_string)
			@runtime = runtime
			@simulator_string = simulator_string
		end

		def id
			/.*\((.*)\) \(.*\)/.match(simulator_string).captures.first
		end

		private
		attr_reader :simulator_string
	end
end