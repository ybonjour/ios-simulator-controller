module IosSimulatorController
	module Tools
		class Xcrun
			def list_simulators
				`xcrun simctl list`
			end

			def install(simulator_id, application_path)
				`xcrun simctl install #{simulator_id} #{application_path}`
			end
		end
	end
end