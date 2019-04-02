RSpec.describe Ovo::GlobalScope do
  describe '#true' do
    it { expect(subject.true).to eq(true) }
  end

  describe '#false' do
    it { expect(subject.false).to eq(false) }
  end
end
