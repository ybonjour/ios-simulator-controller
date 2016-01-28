require 'spec_helper'

describe IosSimulatorController::SimulatorSelector do
	
	let(:simulators) {
		"== Device Types ==\niPhone 4s (com.apple.CoreSimulator.SimDeviceType.iPhone-4s)\niPhone 5 (com.apple.CoreSimulator.SimDeviceType.iPhone-5)\niPhone 5s (com.apple.CoreSimulator.SimDeviceType.iPhone-5s)\niPhone 6 Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus)\niPhone 6 (com.apple.CoreSimulator.SimDeviceType.iPhone-6)\niPad 2 (com.apple.CoreSimulator.SimDeviceType.iPad-2)\niPad Retina (com.apple.CoreSimulator.SimDeviceType.iPad-Retina)\niPad Air (com.apple.CoreSimulator.SimDeviceType.iPad-Air)\nResizable iPhone (com.apple.CoreSimulator.SimDeviceType.Resizable-iPhone)\nResizable iPad (com.apple.CoreSimulator.SimDeviceType.Resizable-iPad)\n== Runtimes ==\niOS 7.0 (7.0 - Unknown) (com.apple.CoreSimulator.SimRuntime.iOS-7-0) (unavailable, runtime path not found)\niOS 7.1 (7.1 - Unknown) (com.apple.CoreSimulator.SimRuntime.iOS-7-1) (unavailable, runtime path not found)\niOS 8.1 (8.1 - 12B411) (com.apple.CoreSimulator.SimRuntime.iOS-8-1)\n== Devices ==\n-- iOS 7.0 --\n-- iOS 7.1 --\n-- iOS 8.1 --\n    iPhone 4s (F63E4A4B-4DAB-4A63-8008-94F2850C2584) (Shutdown)\n    iPhone 5 (E073E7C7-252C-4D0D-8644-D6A7350A0C14) (Shutdown)\n    iPhone 5s (601B5076-2579-4422-83A3-7FA560916357) (Shutdown)\n    iPhone 6 Plus (C61E95EE-E3F8-4250-99BF-D8DB761F62C3) (Shutdown)\n    iPhone 6 (D66C12F6-B649-4CCD-A0CA-313FD8C828DD) (Shutdown)\n    iPad 2 (473C836F-58C1-428C-9C54-B7199EBC5969) (Shutdown)\n    iPad Retina (C3BE87BB-6D45-4FFD-955B-79F19039B0AF) (Shutdown)\n    iPad Air (24C9AEC4-BBB4-4052-A301-F5F5CCFBDB28) (Shutdown)\n    Resizable iPhone (690F9D6A-D059-4277-B358-F50A077D7EEE) (Shutdown)\n    Resizable iPad (481D17A3-E30E-4807-943A-311A03F81670) (Shutdown)\n"
	}

	let(:xcrun) { double('xcrun') }

	subject { described_class.new(xcrun) } 

	before {
		allow(xcrun).to receive(:list_simulators).and_return(simulators)
	}

	context 'when simulator exists' do
		it 'returns a simulator' do
			expect(subject.select('iOS 8.1', 'iPhone 5')).to_not be_nil
		end
	end

	context 'when runtime does not exist' do
		it 'returns nil' do
			expect(subject.select('iOS 2.0', 'iPhone 5')).to be_nil
		end
	end

	context 'when phone does not exist for runtime' do
		it 'returns nil' do
			expect(subject.select('iOS 8.1', 'iPhone 100')).to be_nil
		end
	end

	context 'when phone only exists for a different runtime' do
		it 'returns nil' do
			expect(subject.select('iOS 7.0', 'iPhone 5')).to be_nil
		end
	end
end