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
end
