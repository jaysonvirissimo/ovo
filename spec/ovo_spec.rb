RSpec.describe Ovo do
  it "has a version number" do
    expect(Ovo::VERSION).to be
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
