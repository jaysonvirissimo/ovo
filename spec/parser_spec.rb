RSpec.describe Ovo::Parser do
  describe '.call' do
    context 'with a simple expression' do
      let(:arguments) { syntax_tree[:args] }
      let(:first_argument) { arguments.first }
      let(:operator) { syntax_tree[:operator] }
      let(:program) { '+(a, 10)' }
      let(:second_argument) { arguments.last }
      let(:syntax_tree) { described_class.call(program) }

      it 'builds the proper syntax tree' do
        expect(syntax_tree[:type]).to eq('apply')
        expect(operator[:type]).to eq('word')
        expect(operator[:value]).to eq('+')
        expect(first_argument[:type]).to eq('word')
        expect(first_argument[:value]).to eq('a')
      end
    end
  end
end
