RSpec.describe Ovo::KeyWords do
  let(:scope) { Ovo::GlobalScope.new }

  describe '.define' do
    subject { described_class.define(arguments, scope) }

    context 'with the correct number of arguments' do
      let(:word_expression) { { type: 'word', name: 'x'} }
      let(:number_expression) { { type: 'value', value: 42 } }
      let(:arguments) { [word_expression, number_expression] }

      it 'defines a new word reference' do
        subject
        expect(scope.x).to eq(42)
      end
    end

    context 'with the wrong number of arguments' do
      let(:arguments) { ['yes'] }

      it 'raises and error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.do' do
    let(:arguments) { ['yes'] }

    it 'returns the value of the final evaluation' do
      allow(Ovo::Evaluator).to receive(:call).with('yes', scope).and_return(:sim)
      expect(described_class.do(arguments, scope)).to eq(:sim)
    end
  end

  describe '.if' do
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
    let(:value) { 'Hello, world!' }
    let(:arguments) { [{ type: 'value', value: value }] }

    it 'outputs to standard out' do
      expect { described_class.print(arguments, scope) }.to output(/#{value}/).to_stdout
    end
  end

  describe '.while' do
    context 'with the wrong number of arguments' do
      let(:arguments) { [1, :dois, 3, :quatro] }

      it 'raises an error' do
        calling = -> { described_class.while(arguments, scope) }
        expect { calling.call }.to raise_error(ArgumentError)
      end
    end
  end
end
