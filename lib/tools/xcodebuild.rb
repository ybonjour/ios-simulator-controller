module IosSimulatorController
	module Tools
		class Xcodebuild
			def xcode_major_version
				version_string = `xcodebuild -version`
				/Xcode (\d+)\..*/.match(version_string).captures.first.to_i
			end
		end
	end
end