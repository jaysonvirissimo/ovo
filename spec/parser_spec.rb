RSpec.describe Ovo::Parser do
  describe '.call' do
    context 'with a simple expression' do
      let(:arguments) { syntax_tree[:arguments] }
      let(:first_argument) { arguments.first }
      let(:operator) { syntax_tree[:operator] }
      let(:program) { '+(a, 10)' }
      let(:second_argument) { arguments.last }
      let(:syntax_tree) { described_class.call(program) }

      describe 'builds the proper syntax tree' do
        it { expect(syntax_tree[:type]).to eq('apply') }
        it { expect(operator[:type]).to eq('word') }
        it { expect(operator[:name]).to eq('+') }
        it { expect(first_argument[:type]).to eq('word') }
        it { expect(first_argument[:name]).to eq('a') }
        it { expect(second_argument[:type]).to eq('value') }
        it { expect(second_argument[:value]).to eq(10) }
      end
    end
  end
end
