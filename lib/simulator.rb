module IosSimulatorController
	class Simulator
		attr_reader :runtime

		def initialize(runtime, simulator_string, instruments=Tools::Instruments.new, xcodebuild=Tools::Xcodebuild.new, process_handler=Tools::ProcessHandler.new, xcrun=Tools::Xcrun.new)
			@runtime = runtime
			@simulator_string = simulator_string
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
		end

		def install(application)
			xcrun.install(id, application.path)
		end

		private
		attr_reader :simulator_string, :instruments, :xcodebuild, :process_handler, :xcrun
	end
end