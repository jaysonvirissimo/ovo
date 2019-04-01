RSpec.describe Ovo::KeyWords do
  describe '.if' do
    let(:scope) { Ovo::GlobalScope }

    context 'when the antecendent is true' do
      let(:arguments) { [true, 1, 2] }

      it 'sends the second argument for evaluation' do
        allow(Ovo::Evaluator).to receive(:call)
        described_class.if(arguments, scope)
        expect(Ovo::Evaluator).to have_received(:call).with(1, scope)
      end
    end

    context 'when the antecendent is false' do
      let(:arguments) { [false, 1, 2] }

      it 'sends the third argument for evaluation' do
        allow(Ovo::Evaluator).to receive(:call)
        described_class.if(arguments, scope)
        expect(Ovo::Evaluator).to have_received(:call).with(2, scope)
      end
    end

    context 'with the wrong number of arguments' do
      let(:arguments) { [1, 'two', 3, 'four'] }

      it 'raises an error' do
        calling = -> { described_class.if(arguments, scope) }
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
