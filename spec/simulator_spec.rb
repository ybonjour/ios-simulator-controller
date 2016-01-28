require 'spec_helper'

describe IosSimulatorController::Simulator do 
	let(:instruments) { double('instruments') }
	let(:xcodebuild) { double('xcodebuild') }
	let(:process_handler) { double('process_handler') }
	let(:xcrun) { double('xcrun') }
	let(:runtime) { 'iOS 8.4' }
	let(:simulator_id) { 'E073E7C7-252C-4D0D-8644-D6A7350A0C14' }
	let(:simulator_string) { "iPhone 5 (#{simulator_id}) (Shutdown)" }

	subject { described_class.new(runtime, simulator_string, instruments, xcodebuild, process_handler, xcrun) }

	it 'has the corect runtime' do
		expect(subject.runtime).to be ==  runtime
	end

	it 'has the correct id' do
		expect(subject.id).to be == simulator_id
	end

	describe '#start' do
		it 'uses instruments to start the simulator' do
			expect(instruments).to receive(:launch_simulator).with(simulator_id)
			subject.start
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
		end

		context 'when xocde version is bigger or equal to 7' do
			before {
				allow(xcodebuild).to receive(:xcode_major_version).and_return(7)
			}

			it 'uses process handler to kill all process with Simulator' do
				expect(process_handler).to receive(:killall).with('Simulator')
				subject.stop
			end
		end
	end

	describe '#install' do
		let(:application) { IosSimulatorController::Application.new("/some/path/to/Application.app") }
		it 'uses xcrun to install the application on the device' do
			expect(xcrun).to receive(:install).with(simulator_id, application.path)
			subject.install(application)
		end
	end
end