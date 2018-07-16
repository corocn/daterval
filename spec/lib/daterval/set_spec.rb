RSpec.describe Daterval::Set do
  describe '#initialize' do
    context 'no argument' do
      subject do
        described_class.new
      end

      it 'has 0 count' do
        expect(subject.count).to eq(0)
      end
    end

    context 'only one argument' do
      subject do
        described_class.new(
          Daterval::Pair.new('2018/01/01 00:00:00', '2018/01/02 00:00:00')
        )
      end

      it 'has one pair' do
        expect(subject.count).to eq(1)
      end
    end

    context 'multiple arguments' do
      subject do
        described_class.new(
          Daterval::Pair.new('2018/01/01 00:00:00', '2018/01/02 00:00:00'),
          Daterval::Pair.new('2018/01/03 00:00:00', '2018/01/04 00:00:00')
        )
      end

      it 'has multiple pairs' do
        expect(subject.count).to eq(2)
      end
    end
  end
end
