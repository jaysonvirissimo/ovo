RSpec.describe Ovo::GlobalScope do
  describe '.true' do
    it { expect(described_class.true).to eq(true) }
  end

  describe '.false' do
    it { expect(described_class.false).to eq(false) }
  end
end
