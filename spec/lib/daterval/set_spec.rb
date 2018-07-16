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

  describe '#merged!' do
    context 'all pairs to 1 pair' do
      subject do
        described_class.new(
          Daterval::Pair.new('2018/01/03 00:00:00', '2018/01/04 00:00:00'),
          Daterval::Pair.new('2018/01/02 00:00:00', '2018/01/03 00:00:00'),
          Daterval::Pair.new('2018/01/01 00:00:00', '2018/01/02 00:00:00')
        ).merged!
      end

      it do
        expect(subject.count).to eq(1)
        expect(subject.list.first.begin).to eq(Time.parse('2018/01/01 00:00:00'))
        expect(subject.list.first.end).to eq(Time.parse('2018/01/04 00:00:00'))
      end
    end

    context 'all pairs still seperated ' do
      subject do
        described_class.new(
          Daterval::Pair.new('2018/01/03 00:00:01', '2018/01/04 00:00:00'),
          Daterval::Pair.new('2018/01/02 00:00:01', '2018/01/03 00:00:00'),
          Daterval::Pair.new('2018/01/01 00:00:00', '2018/01/02 00:00:00')
        ).merged!
      end

      it do
        expect(subject.count).to eq(3)

        expect(subject.list[0].begin).to eq(Time.parse('2018/01/01 00:00:00'))
        expect(subject.list[0].end).to eq(Time.parse('2018/01/02 00:00:00'))

        expect(subject.list[1].begin).to eq(Time.parse('2018/01/02 00:00:01'))
        expect(subject.list[1].end).to eq(Time.parse('2018/01/03 00:00:00'))

        expect(subject.list[2].begin).to eq(Time.parse('2018/01/03 00:00:01'))
        expect(subject.list[2].end).to eq(Time.parse('2018/01/04 00:00:00'))
      end
    end

    context 'some of all pairs merged' do
      subject do
        described_class.new(
          Daterval::Pair.new('2018/01/03 00:00:01', '2018/01/04 00:00:00'),
          Daterval::Pair.new('2018/01/01 00:00:00', '2018/01/02 00:00:00'),
          Daterval::Pair.new('2018/01/02 00:00:00', '2018/01/03 00:00:00')
        ).merged!
      end

      it do
        expect(subject.count).to eq(2)

        expect(subject.list[0].begin).to eq(Time.parse('2018/01/01 00:00:00'))
        expect(subject.list[0].end).to eq(Time.parse('2018/01/03 00:00:00'))

        expect(subject.list[1].begin).to eq(Time.parse('2018/01/03 00:00:01'))
        expect(subject.list[1].end).to eq(Time.parse('2018/01/04 00:00:00'))
      end
    end
  end
end
