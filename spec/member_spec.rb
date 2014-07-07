require 'rspec'
require_relative '../lib/member.rb'

describe Member do
  describe '#update' do
    context 'when class location are not registered groups' do
      let(:member) { Member.new(esme_with_update) }

      before do
        allow(Group).to receive(:find_or_create).
                          with( group_name: esme_with_update['merges']['CLASS'],
                                grouping_id: 11111,
                                grouping_name: 'CLASS').
                                  and_return( esme_with_update['merges']['CLASS'] )
        allow(Group).to receive(:find_or_create).
                          with( group_name: esme_with_update['merges']['CLASSLOC'],
                                grouping_id: 22222,
                                grouping_name: 'CLASSLOC').
                                  and_return( esme_with_update['merges']['CLASSLOC'] )
      end

      it 'updates the member with the newly created groups' do
        expect(MailChimp).to receive(:update_member).
                          with( email: esme_with_update['email'],
                                grouping_class: esme_with_update['merges']['CLASS'],
                                grouping_location: esme_with_update['merges']['CLASSLOC'])
        member.update
      end
    end

    context 'when class location are empty strings' do
      let(:member) { Member.new(esme_no_update) }

      before do
        allow(Group).to receive(:find_or_create).
                          with( group_name: esme_no_update['merges']['CLASS'],
                                grouping_id: 11111,
                                grouping_name: 'CLASS').and_return( nil )
        allow(Group).to receive(:find_or_create).
                          with( group_name: esme_no_update['merges']['CLASSLOC'],
                                grouping_id: 22222,
                                grouping_name: 'CLASSLOC').and_return( nil )
      end

      it 'updates the member with the newly created groups' do
        expect(MailChimp).not_to receive(:update_member)
        member.update
      end
    end
  end
end

def esme_with_update
  {"email"=>"esme@kittyheaven.com", "id"=>"1111111", "list_name"=>"Master List", "merges"=>{"EMAIL"=>"esme@kittyheaven.com", "FNAME"=>"", "LNAME"=>"", "CITY"=>"", "STATE"=>"NY", "COUNTRY"=>"US", "CLASS"=>"Fishing", "CLASSDATE"=>"", "CLASSLOC"=>"Texas", "INTEREST"=>"", "EVENT"=>"", "ADDRESS"=>"", "ZIP"=>"", "PHONE"=>"", "COMPANY"=>"", "SIGNUPLOC"=>"", "GROUPINGS"=>[{"id"=>11111, "name"=>"Classes", "form_field"=>"hidden", "groups"=>[{"name"=>"Scratching", "interested"=>false}, {"name"=>"Cuteness Camp", "interested"=>false}]}, {"id"=>22222, "name"=>"Class Locations", "form_field"=>"hidden", "groups"=>[{"name"=>"Scratching Post", "interested"=>false}, {"name"=>"Under The Sofa", "interested"=>false}]}]}, "status"=>"subscribed", "timestamp"=>"2014-06-27 14:46:40", "is_gmonkey"=>false, "lists"=>[{"id"=>"7720e2f1a6", "status"=>"subscribed"}, {"id"=>"fda4db3715", "status"=>"subscribed"}], "geo"=>[], "clients"=>[], "static_segments"=>[], "notes"=>[]}
end

def esme_no_update
  {"email"=>"esme@kittyheaven.com", "id"=>"1111111", "list_name"=>"Master List", "merges"=>{"EMAIL"=>"esme@kittyheaven.com", "FNAME"=>"", "LNAME"=>"", "CITY"=>"", "STATE"=>"NY", "COUNTRY"=>"US", "CLASS"=>"", "CLASSDATE"=>"", "CLASSLOC"=>"", "INTEREST"=>"", "EVENT"=>"", "ADDRESS"=>"", "ZIP"=>"", "PHONE"=>"", "COMPANY"=>"", "SIGNUPLOC"=>"", "GROUPINGS"=>[{"id"=>11111, "name"=>"Classes", "form_field"=>"hidden", "groups"=>[{"name"=>"Scratching", "interested"=>false}, {"name"=>"Cuteness Camp", "interested"=>false}]}, {"id"=>22222, "name"=>"Class Locations", "form_field"=>"hidden", "groups"=>[{"name"=>"Scratching Post", "interested"=>false}, {"name"=>"Under The Sofa", "interested"=>false}]}]}, "status"=>"subscribed", "timestamp"=>"2014-06-27 14:46:40", "is_gmonkey"=>false, "lists"=>[{"id"=>"7720e2f1a6", "status"=>"subscribed"}, {"id"=>"fda4db3715", "status"=>"subscribed"}], "geo"=>[], "clients"=>[], "static_segments"=>[], "notes"=>[]}
end
