RSpec.describe Daterval::Pair do
  describe '#initialize' do
    let(:start_time) { Time.parse('2018/01/01 00:00') }
    let(:end_time) { Time.parse('2018/01/02 00:00') }
    subject { described_class.new(start_time, end_time) }

    it 'could set both start and end' do
      expect(subject.start_time).to eq(start_time)
      expect(subject.end_time).to eq(end_time)
    end

    describe 'initialize with swapping start and end' do
      context 'day' do
        let(:start_time) { Time.parse('2018/01/02 00:00') }
        let(:end_time) { Time.parse('2018/01/01 00:00') }

        it do
          expect(subject.start_time).to eq(end_time)
          expect(subject.end_time).to eq(start_time)
        end
      end

      context 'time' do
        let(:start_time) { Time.parse('2018/01/01 12:00:01') }
        let(:end_time) { Time.parse('2018/01/01 12:00:00') }

        it do
          expect(subject.start_time).to eq(end_time)
          expect(subject.end_time).to eq(start_time)
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
end
