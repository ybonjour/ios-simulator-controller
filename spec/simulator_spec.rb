require 'spec_helper'

describe IosSimulatorController::Simulator do 
	let(:instruments) { double('instruments') }
	let(:xcodebuild) { double('xcodebuild') }
	let(:process_handler) { double('process_handler') }
	let(:xcrun) { double('xcrun') }
	let(:runtime) { 'iOS 8.4' }
	let(:simulator_id) { 'E073E7C7-252C-4D0D-8644-D6A7350A0C14' }
	let(:booted_simulator_string) { "iPhone 5 (#{simulator_id}) (Booted)" }
	let(:shutdown_simulator_string) { "iPhone 5 (#{simulator_id}) (Shutdown)" }
	let(:booted_simulator) { described_class.new(runtime, booted_simulator_string, instruments, xcodebuild, process_handler, xcrun) }
	let(:shutdown_simulator) { described_class.new(runtime, shutdown_simulator_string, instruments, xcodebuild, process_handler, xcrun) }

	subject { booted_simulator }

	describe '#initialize' do
		it 'has the corect runtime' do
			expect(subject.runtime).to be ==  runtime
		end

		it 'has the correct id' do
			expect(subject.id).to be == simulator_id
		end

		context 'when simulator is initially booted' do		
			it 'creates a booted simulator' do
				expect(subject.booted?).to be_truthy
			end
		end

		context 'when the simulator is initially shutdown' do
			subject { shutdown_simulator }
			it 'creates a non-booted simulator' do
				expect(subject.booted?).to be_falsey
			end
		end
	end

	describe '#start' do
		it 'uses instruments to start the simulator' do
			expect(instruments).to receive(:launch_simulator).with(simulator_id)
			subject.start
		end

		it 'sets simulator state to booted' do
			allow(instruments).to receive(:launch_simulator)
			subject.start
			expect(subject.booted?).to be_truthy
		end
	end

	describe '#stop' do
		context 'when xocde version is smaller or equal to 6' do
			before {
				allow(xcodebuild).to receive(:xcode_major_version).and_return(6)
			}

			it 'uses process handler to kill all process with iOS Simulator' do
				expect(process_handler).to receive(:killall).with('iOS Simulator')
				subject.stop
			end

			it 'sets simulator state to shutdown' do
				allow(process_handler).to receive(:killall)
				subject.stop
				expect(subject.booted?).to be_falsey
			end
		end

		context 'when xocde version is bigger or equal to 7' do
			before {
				allow(xcodebuild).to receive(:xcode_major_version).and_return(7)
			}

			it 'uses process handler to kill all process with Simulator' do
				expect(process_handler).to receive(:killall).with('Simulator')
				subject.stop
			end

			it 'sets simulator state to shutdown' do
				allow(process_handler).to receive(:killall)
				subject.stop
				expect(subject.booted?).to be_falsey
			end
		end
	end

	describe '#install' do
		let(:application) { double("application", :path => "/some/path/to/Application.app") }
		it 'uses xcrun to install the application on the simulator' do
			expect(xcrun).to receive(:install).with(simulator_id, application.path)
			subject.install(application)
		end

		context 'when simulator has not been started' do
			subject { shutdown_simulator }
			it 'raises an error' do
				expect { subject.install(application) }.to raise_error("simulator hasn't been started")
			end
		end
	end

	describe '#uninstall' do
		let(:application) { double("application", :bundle_identifier => "com.myapplication.prod") }
		it 'uses xcrun to uninstall the application from the simulator' do
			expect(xcrun).to receive(:uninstall).with(simulator_id, application.bundle_identifier)
			subject.uninstall(application)
		end

		context 'when simulator has not been started' do
			subject { shutdown_simulator }
			it 'raises an error' do
				expect { subject.uninstall(application) }.to raise_error("simulator hasn't been started")
			end
		end
	end

	describe '#launch' do
		let(:application) { double("application", :bundle_identifier => "com.myapplication.prod") }
		let(:arguments) { ['arg1', 'arg2'] }
		it 'uses xcrun to launch the application on the simulator' do
			expect(xcrun).to receive(:launch).with(simulator_id, application.bundle_identifier, arguments)
			subject.launch(application, arguments)
		end

		context 'when simulator has not been started' do
			subject { shutdown_simulator }
			it 'raises an error' do
				expect { subject.launch(application) }.to raise_error("simulator hasn't been started")
			end
		end
	end

	describe '#close' do
		let(:application) { double("application", :executable => "MyApp")}
		it 'kills the process with the applications executable name' do
			expect(process_handler).to receive(:killall).with(application.executable)
			subject.close(application)
		end

		context 'when simulator has not been started' do
			subject { shutdown_simulator }
			it 'raises an error' do
				expect { subject.close(application) }.to raise_error("simulator hasn't been started")
			end
		end
	end


	describe '#erase_contents_and_settings' do
		subject { shutdown_simulator }
		it 'uses xcrun to erase contents and settings of simulator' do
			expect(xcrun).to receive(:erase).with(simulator_id)
			subject.erase_contents_and_settings
		end

		context 'when simulator is still running' do
			subject { booted_simulator }
			it 'raises an error' do
				expect { subject.erase_contents_and_settings }.to raise_error("simulator needs to be stopped to erase data")
			end
		end
	end
end