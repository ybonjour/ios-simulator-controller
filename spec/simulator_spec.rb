require 'spec_helper'

describe IosSimulatorController::Simulator do 
	let(:instruments) { double('instruments') }
	let(:runtime) { 'iOS 8.4' }
	let(:simulator_id) { 'E073E7C7-252C-4D0D-8644-D6A7350A0C14' }
	let(:simulator_string) { "iPhone 5 (#{simulator_id}) (Shutdown)" }

	subject { described_class.new(runtime, simulator_string, instruments) }

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
end