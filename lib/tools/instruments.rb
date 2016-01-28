module IosSimulatorController
	module Tools
		class Instruments
			def launch_simulator(id)
				`instruments -w #{id}`
			end
		end
	end
end