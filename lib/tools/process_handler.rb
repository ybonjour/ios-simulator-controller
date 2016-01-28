module IosSimulatorController
	module Tools
		class ProcessHandler
			def killall(name)
				`killall "#{name}"`
			end
		end
	end
end