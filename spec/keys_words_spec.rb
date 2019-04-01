RSpec.describe Ovo::KeyWords do
  describe '#print' do
    let(:value) { 'ovos verdes e presunto' }

    it 'outputs to standard out' do
      expect { described_class.print(value) }.to output(/#{value}/).to_stdout
    end
  end
end
