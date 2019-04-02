RSpec.describe Ovo::Evaluator do
  describe '#call' do
    context 'with a string expression' do
      let(:instance) { described_class.new(syntax_tree, Ovo::GlobalScope) }
      let(:syntax_tree) do
        { type: 'value', value: 'foo' }
      end

      it { expect(instance.call).to match(/foo/) }
    end
  end
end
