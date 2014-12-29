require 'spec_helper'

describe Letsfreckle::Client::Project do
  let(:json_hash) {
    {"expenses_url"=>"https://api.letsfreckle.com/v2/projects/250051/expenses",
     "uninvoiced_minutes"=>0,
     "url"=>"https://api.letsfreckle.com/v2/projects/250051",
     "name"=>"test create",
     "expenses"=>0,
     "participants"=>[],
     "updated_at"=>"2014-11-18T01:08:58Z",
     "entries_url"=>"https://api.letsfreckle.com/v2/projects/250051/entries",
     "entries"=>0,
     "created_at"=>"2014-11-18T01:08:58Z",
     "remaining_minutes"=>nil,
     "billable_minutes"=>0,
     "enabled"=>true,
     "invoiced_minutes"=>0,
     "minutes"=>0,
     "id"=>250051,
     "invoices"=>[],
     "unbillable_minutes"=>0,
     "budgeted_minutes"=>nil,
     "billing_increment"=>15,
     "group"=>nil,
     "color"=>"#ef5555",
     "billable"=>true}
  }
  it 'can be set from a hash' do
    subject.load(json_hash)
    expect(subject.name).to eql 'test create'
  end

  context 'connected' do
    before do
      setup_connection
    end
    it 'finds the project by its id' do
      project = subject.class.find(250051)
      expect(project).to be_a Letsfreckle::Client::Project
    end
    it 'returns a NoProject if not found' do
      expect(subject.class.find(-1)).to be_a Letsfreckle::Client::NoProject
    end
    it 'finds projects by a given filter' do
      expect(subject.class.find_by(name: 'test create').first).to be_a Letsfreckle::Client::Project
    end
    it 'returns an empty array if no projects match' do
      expect(subject.class.find_by(name: 'some probably non-existing project name')).to eql([])
    end
    context 'find_entries' do
      let(:project) { subject.class.find(8475) }
      it 'has entries' do
        expect(project.find_entries).to be_an Array
        expect(project.find_entries.first).to be_an Letsfreckle::Client::Entry
      end
      it 'reload on true' do
        expect(project.find_entries(true)).to be_an Array
      end
    end
  end
end
