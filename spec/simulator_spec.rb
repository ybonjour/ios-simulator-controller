require 'spec_helper'

describe IosSimulatorController::Simulator do 
	let(:runtime) { 'iOS 8.4' }
	let(:simulator_string) { 'iPhone 5 (E073E7C7-252C-4D0D-8644-D6A7350A0C14) (Shutdown)' }

	subject { described_class.new(runtime, simulator_string) }

	it 'has the corect runtime' do
		expect(subject.runtime).to be ==  runtime
	end

	it 'has the correct id' do
		expect(subject.id).to be == 'E073E7C7-252C-4D0D-8644-D6A7350A0C14'
	end
end