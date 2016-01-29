module IosSimulatorController
	module Tools
		class Xcrun
			def list_simulators
				`xcrun simctl list`
			end

			def install(simulator_id, application_path)
				`xcrun simctl install #{simulator_id} #{application_path}`
			end

			def uninstall(simulator_id, bundle_identifier)
				`xcrun simctl uninstall #{simulator_id} #{bundle_identifier}`
			end

			def launch(simulator_id, bundle_identifier, arguments)
				`xcrun simctl launch #{simulator_id} #{bundle_identifier} #{arguments.join(", ")}`
			end

			def erase(simulator_id)
				`xcrun simctl erase #{simulator_id}`
			end
		end
	end
end