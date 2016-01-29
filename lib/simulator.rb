module IosSimulatorController
	class Simulator
		attr_reader :runtime

		STATE_SHUTDOWN = :shutdown
		STATE_BOOTED = :booted

		def initialize(runtime, simulator_string, instruments=Tools::Instruments.new, xcodebuild=Tools::Xcodebuild.new, process_handler=Tools::ProcessHandler.new, xcrun=Tools::Xcrun.new)
			@runtime = runtime
			@simulator_string = simulator_string
			@state = extract_state(simulator_string)
			@instruments = instruments
			@xcodebuild = xcodebuild
			@process_handler = process_handler
			@xcrun = xcrun
		end

		def id
			/.*\((.*)\) \(.*\)/.match(simulator_string).captures.first
		end

		def start
			instruments.launch_simulator(id)
			@state = STATE_BOOTED
		end

		def stop
			# Check this link for the difference between xcode 6 and 7
			# http://stackoverflow.com/questions/8064120/is-there-a-way-to-close-the-ios-simulator-from-the-command-line
			xcode_version = xcodebuild.xcode_major_version

			if xcode_version <= 6
				process_handler.killall("iOS Simulator")
			else
				process_handler.killall("Simulator")
			end
			@state = STATE_SHUTDOWN
		end

		def install(application)
			xcrun.install(id, application.path)
		end

		def uninstall(application)
			xcrun.uninstall(id, application.bundle_identifier)
		end

		def launch(application, arguments=[])
			xcrun.launch(id, application.bundle_identifier, arguments)
		end

		def close(application)
			process_handler.killall(application.executable)
		end

		def erase_contents_and_settings
			xcrun.erase(id)
		end

		def booted?
			@state == STATE_BOOTED
		end

		private
		attr_reader :simulator_string, :instruments, :xcodebuild, :process_handler, :xcrun

		def extract_state(simulator_string)
			/.*\(.*\) \((Booted)\)/ =~ simulator_string ? STATE_BOOTED : STATE_SHUTDOWN
		end
	end
end