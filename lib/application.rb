require 'cfpropertylist'

module IosSimulatorController
	class Application
		attr_reader :path

		def initialize(application_path)
			@path = application_path
			@info_plist = File.join(application_path, 'Info.plist')
			@data = CFPropertyList.native_types(CFPropertyList::List.new(:file => @info_plist).value)
		end

		def bundle_identifier
			data['CFBundleIdentifier']
		end

		def executable
			data['CFBundleExecutable']
		end

		private
		attr_reader :data
	end
end