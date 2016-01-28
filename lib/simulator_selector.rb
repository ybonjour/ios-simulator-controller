module IosSimulatorController
	class SimulatorSelector
		def initialize(xcrun=Tools::Xcrun.new)
			@xcrun = xcrun
		end


		def select(runtime, phone)
			lines = xcrun.list_simulators.split("\n")
			idx = 0
			current_runtime = nil
			until idx == lines.size do
				line = lines[idx]

				line_runtime = runtime(line)
				if line_runtime
					current_runtime = line_runtime
				end

				if current_runtime == runtime and phone?(phone, line)
					return Simulator.new(runtime, line)
				end
				idx += 1
			end

			return nil
		end

		private
		attr_reader :xcrun

		def phone?(phone, line)
			/#{phone}.*/ =~ line
		end

		def runtime(line)
			matches = /-- (.*) --/.match(line)
			matches ? matches.captures.first : nil 
		end
	end
end