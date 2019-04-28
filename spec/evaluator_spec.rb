RSpec.describe Ovo::Evaluator do
  describe '#call' do
    let(:instance) { described_class.new(syntax_tree, scope) }

    context 'with an apply expression' do
      context 'with an undefined operator' do
        context 'that is not a function' do
          let(:scope) { Ovo::GlobalScope.new }
          let(:syntax_tree) do
            double(
              type: 'apply',
              operator: double(name: 'indefinido', type: 'value'),
              arguments: []
            )
          end

          it 'raises an error' do
            expect { instance.call }.to raise_error(TypeError)
          end
        end
      end
    end

    context 'with a string expression' do
      let(:scope) { Ovo::GlobalScope.new }
      let(:syntax_tree) { double(type: 'value', value: 'foo') }

      it { expect(instance.call).to match(/foo/) }
    end

    context 'with a word expression' do
      let(:syntax_tree) do
        double(type: 'word', name: 'palavra')
      end

      context 'that is defined within the local scope' do
        let(:scope) do
          Ovo::GlobalScope.new.tap do |scope|
            scope.palavra = 'is a thing'
          end
        end

        it 'returns the proper value' do
          expect(instance.call).to match(/is a thing/)
        end
      end

      context 'that is not defined in the local scope' do
        let(:scope) { Ovo::GlobalScope }

        it 'raises an error' do
          expect { instance.call }.to raise_error(NameError)
        end
      end
    end
  end
end
