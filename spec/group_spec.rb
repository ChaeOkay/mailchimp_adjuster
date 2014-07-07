require 'rspec'
require_relative '../lib/group.rb'

describe Group do
  describe '#find_or_create' do
    context 'when the group name is empty' do
      let(:group_params) { { group_name: '',
                             grouping_id: 11111,
                             grouping_name: 'Classes' } }

      it 'should return an empty group' do
        group = Group.find_or_create(group_params)
        expect(group).to be_nil
      end

      it 'should not call an instance of find_or_create' do
        expect_any_instance_of(Group).to_not receive(:find_or_create)
        Group.new(group_params)
      end
    end

    context 'when the group name is found' do
      let(:group_params) { { group_name: 'Beginning iOS',
                             grouping_id: 11111,
                             grouping_name: 'Classes' } }
      let(:group) { Group.find_or_create(group_params) }

      before do
        allow(MailChimp).to receive(:groupings).and_return(groupings)
      end

      it 'has a group name' do
        expect(group.group_name).to eq group_params[:group_name]
      end

      it 'has a grouping name' do
        expect(group.grouping_name).to eq group_params[:grouping_name]
      end

      it 'has a grouping id' do
        expect(group.grouping_id).to eq group_params[:grouping_id]
      end
    end

    context 'when the group name is created' do
      let(:group_params) { { group_name: 'Kite Flying',
                             grouping_id: 11111,
                             grouping_name: 'Classes' } }
      let(:group) { Group.find_or_create(group_params) }

      before do
        allow(MailChimp).to receive(:groupings).and_return(groupings)
        allow(MailChimp).to receive(:create_group).and_return({ "complete"=>true })
      end

      it 'has a group name' do
        expect(group.group_name).to eq group_params[:group_name]
      end

      it 'has a grouping name' do
        expect(group.grouping_name).to eq group_params[:grouping_name]
      end

      it 'has a grouping id' do
        expect(group.grouping_id).to eq group_params[:grouping_id]
      end
    end
  end
end

def groupings
  [{"id"=>9805, "name"=>"Interested in", "form_field"=>"hidden", "display_order"=>"0", "groups"=>[{"id"=>341, "bit"=>"1", "name"=>"Aspiring Students", "display_order"=>"5", "subscribers"=>nil}, {"id"=>353, "bit"=>"2", "name"=>"App Development", "display_order"=>"8", "subscribers"=>nil}, {"id"=>361, "bit"=>"8", "name"=>"Corporate Training", "display_order"=>"10", "subscribers"=>nil}]}, {"id"=>9809, "name"=>"Downloadables", "form_field"=>"hidden", "display_order"=>"0", "groups"=>[{"id"=>357, "bit"=>"4", "name"=>"Xcode Tip Sheet", "display_order"=>"9", "subscribers"=>nil}]}, {"id"=>11111, "name"=>"Classes", "form_field"=>"hidden", "display_order"=>"0", "groups"=>[{"id"=>365, "bit"=>"16", "name"=>"Beginning iOS", "display_order"=>"11", "subscribers"=>nil}, {"id"=>501, "bit"=>"64", "name"=>"Cocoa I Bootcamp", "display_order"=>"13", "subscribers"=>nil}]}, {"id"=>22222, "name"=>"Class Locations", "form_field"=>"hidden", "display_order"=>"0", "groups"=>[{"id"=>369, "bit"=>"32", "name"=>"Asilomar", "display_order"=>"12", "subscribers"=>nil}, {"id"=>505, "bit"=>"128", "name"=>"Historic Banning Mills", "display_order"=>"14", "subscribers"=>nil}]}]
end
