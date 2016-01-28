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

			def launch(simulator_id, bundle_identifier)
				`xcrun simctl launch #{simulator_id} #{bundle_identifier}`
			end
		end
	end
end