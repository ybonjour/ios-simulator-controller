module IosSimulatorController
	module Tools
		class Xcrun
			def list_simulators
				`xcrun simctl list`
			end
		end
	end
end