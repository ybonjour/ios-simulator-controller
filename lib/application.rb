module IosSimulatorController
	class Application
		attr_reader :path

		def initialize(application_path)
			@path = application_path
		end
	end
end