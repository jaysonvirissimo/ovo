RSpec.describe Ovo do
  it "has a version number" do
    expect(Ovo::VERSION).to be
  end

  describe ".run" do
    subject { described_class.run(program) }

    context 'with a program of a single expression' do
      let(:program) { 'print(42)' }

      it { expect(subject).to eq(42)}
    end

    context 'with a non-trivial program' do
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

      it { expect(subject).to eq(55) }
    end
  end
end
