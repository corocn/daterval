RSpec.describe Daterval::Pair do
  describe '#initialize' do
    let(:begin_time) { Time.parse('2018/01/01 00:00') }
    let(:end_time) { Time.parse('2018/01/02 00:00') }
    subject { described_class.new(begin_time, end_time) }

    it 'could set both start and end' do
      expect(subject.begin).to eq(begin_time)
      expect(subject.end).to eq(end_time)
    end

    context 'when string time' do
      let(:begin_time) { '2018/01/01 00:00' }
      let(:end_time) { '2018/01/02 00:00' }

      it 'parsed' do
        expect(subject.begin).to be_a(Time)
        expect(subject.end).to be_a(Time)
        expect(subject.to_i).to eq(24 * 60 * 60)
      end
    end

    describe 'initialize with swapping start and end' do
      context 'day' do
        let(:begin_time) { Time.parse('2018/01/02 00:00') }
        let(:end_time) { Time.parse('2018/01/01 00:00') }

        it do
          expect(subject.begin).to eq(end_time)
          expect(subject.end).to eq(begin_time)
        end
      end

      context 'time' do
        let(:begin_time) { Time.parse('2018/01/01 12:00:01') }
        let(:end_time) { Time.parse('2018/01/01 12:00:00') }

        it do
          expect(subject.begin).to eq(end_time)
          expect(subject.end).to eq(begin_time)
        end
      end
    end
  end

  describe '#to_i' do
    it 'day' do
      expect(
        described_class.new(
          Time.parse('2018/01/01 00:00'),
          Time.parse('2018/01/02 00:00')
        ).to_i
      ).to eq(24 * 60 * 60)
    end

    it 'minute' do
      expect(
        described_class.new(
          Time.parse('2018/01/01 00:00'),
          Time.parse('2018/01/01 23:59')
        ).to_i
      ).to eq(24 * 60 * 60 - 60)
    end

    it 'second' do
      expect(
        described_class.new(
          Time.parse('2018/01/01 00:00:01'),
          Time.parse('2018/01/01 00:00:03')
        ).to_i
      ).to eq(2)
    end

    it 'over month' do
      expect(
        described_class.new(
          Time.parse('2018/01/31 12:00'),
          Time.parse('2018/02/01 12:00')
        ).to_i
      ).to eq(24 * 60 * 60)
    end

    it 'zero' do
      expect(
        described_class.new(
          Time.parse('2018/01/01 00:00'),
          Time.parse('2018/01/01 00:00')
        ).to_i
      ).to eq(0)
    end
  end

  describe '#overlaps? and #overlap' do
    context 'same' do
      let(:pair1) { described_class.new('2018/01/01 00:00', '2018/01/02 00:00') }
      let(:pair2) { described_class.new('2018/01/01 00:00', '2018/01/02 00:00') }

      it do
        expect(pair1.overlaps?(pair2)).to be_truthy
        expect(pair1.overlap(pair2)).to eq(described_class.new('2018/01/01 00:00', '2018/01/02 00:00'))
      end
    end

    context 'overlap pair1 front' do
      let(:pair1) { described_class.new('2018/01/01 00:00', '2018/01/02 00:00') }
      let(:pair2) { described_class.new('2018/01/01 12:34', '2018/01/02 12:34') }

      it do
        expect(pair1.overlaps?(pair2)).to be_truthy
        expect(pair1.overlap(pair2)).to eq(described_class.new('2018/01/01 00:00', '2018/01/02 12:34'))
      end
    end

    context 'overlap pair2 front' do
      let(:pair1) { described_class.new('2018/01/01 12:34', '2018/01/02 12:34') }
      let(:pair2) { described_class.new('2018/01/01 00:00', '2018/01/02 00:00') }

      it do
        expect(pair1.overlaps?(pair2)).to be_truthy
        expect(pair1.overlap(pair2)).to eq(described_class.new('2018/01/01 00:00', '2018/01/02 12:34'))
      end
    end

    context 'not overlapped but return new pair with max range' do
      let(:pair1) { described_class.new('2018/01/01 12:34', '2018/01/02 12:34') }
      let(:pair2) { described_class.new('2018/01/02 12:35', '2018/01/03 12:34') }

      it do
        expect(pair1.overlaps?(pair2)).to be_falsey
        expect(pair1.overlap(pair2)).to eq(described_class.new('2018/01/01 12:34', '2018/01/03 12:34'))
      end
    end
  end
end
