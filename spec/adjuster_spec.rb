require 'rspec'
require_relative '../lib/adjuster.rb'

describe Adjuster do

  let(:adjuster) { Adjuster.new }

  describe '#update_all_members' do
    describe 'when there are no more members to iterate on' do
      before do
        allow(Member).to receive(:update)
        allow(MailChimp).to receive(:members).with(1).and_return(["member1", "member2", "member3"])
        allow(MailChimp).to receive(:members).with(2).and_return(["member4", "member5", "member6"])
        allow(MailChimp).to receive(:members).with(3).and_return([])
        allow(MailChimp).to receive(:members).with(4).and_return(["Oops!"])
        adjuster.update_all_members
      end

      it 'does not increment batch past 3' do
        expect(adjuster.batch).to eq 3
      end

      it 'has an empty array for unreviewed_members' do
        expect(adjuster.unreviewed_members).to be_empty
      end
    end
  end

  describe '#load_unreviewed_members' do
    before do
      allow(MailChimp).to receive(:members).with(1).and_return(["member1", "member2", "member3"])
    end

    it 'increments the batch by 1' do
      adjuster.load_unreviewed_members
      expect(adjuster.batch).to eq 1
    end

    it 'sets new unreviewed members' do
      adjuster.load_unreviewed_members
      expect(adjuster.unreviewed_members.size).to eq 3
    end
  end
end
