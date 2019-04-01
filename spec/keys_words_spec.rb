RSpec.describe Ovo::KeyWords do
  describe '.if' do
    xcontext 'when the antecendent is true' do
    end

    xcontext 'when the antecendent is false' do
    end

    context 'with the wrong number of arguments' do
      let(:arguments) { [1, 'two', 3, 'four'] }

      it 'raises an error' do
        calling = -> { described_class.if(arguments, Ovo::GlobalScope) }
        expect { calling.call }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.print' do
    let(:value) { 'ovos verdes e presunto' }

    it 'outputs to standard out' do
      expect { described_class.print(value) }.to output(/#{value}/).to_stdout
    end
  end
end
