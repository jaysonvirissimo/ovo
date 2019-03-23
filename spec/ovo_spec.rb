RSpec.describe Ovo do
  it "has a version number" do
    expect(Ovo::VERSION).to be
  end

  describe '.parse' do
    context 'with a simple expression' do
      let(:arguments) { syntax_tree[:args] }
      let(:first_argument) { arguments.first }
      let(:operator) { syntax_tree[:operator] }
      let(:program) { '+(a, 10)' }
      let(:second_argument) { arguments.last }
      let(:syntax_tree) { described_class.parse(program) }

      it 'builds the proper syntax tree' do
        expect(syntax_tree[:type]).to eq('apply')
        expect(operator[:type]).to eq('word')
        expect(operator[:value]).to eq('+')
        expect(first_argument[:type]).to eq('word')
        expect(first_argument[:value]).to eq('a')
      end
    end
  end

  describe ".run" do
    let(:program) do
      <<~PROGRAM
        do(define(total, 0),
          define(count, 1),
          while(<(count, 11),
                do(define(total, +(total, count)),
                   define(count, +(count, 1)))),
          print(total))
      PROGRAM
    end

    it { expect(described_class.run(program)).to eq(55) }
  end
end
