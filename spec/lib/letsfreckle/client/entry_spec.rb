require 'spec_helper'

describe Letsfreckle::Client::Entry do
  let(:json_hash) {
    {
      "user"=> {
        "email"=>"apitest@letsfreckle.com",
        "last_name"=>"user",
        "profile_image_url"=>"",
        "first_name"=>"test",
        "id"=>5543
      },
     "invoice"=>nil,
     "updated_at"=>"2014-05-14T11:34:39Z",
     "project"=>{
       "name"=>"Fixture Company",
       "enabled"=>true,
       "id"=>8475,
       "billing_increment"=>5,
       "color"=>"#13a480",
       "billable"=>true
     },
     "created_at"=>"2014-05-14T11:34:39Z",
     "invoiced_at"=>nil,
     "source_url"=>nil,
     "minutes"=>60,
     "id"=>6088105,
     "invoiced"=>false,
     "date"=>"2014-04-04",
     "tags"=>[],
     "description"=>"test",
     "billable"=>true
    }
  }
  it 'can be set from a hash' do
    subject.load(json_hash)
    expect(subject.description).to eql 'test'
    expect(subject.user_id).to eql 5543
    expect(subject.project_id).to eql 8475
  end

  it 'gives a params hash that can be used to update or save' do
    subject.load(json_hash)
    expect(subject.to_params).to eql(
      {
        date: "2014-04-04",
        user_id: 5543,
        minutes: 60,
        project_id: 8475,
        description: 'test'
      }
    )
  end

  context 'connected' do
    before do
      setup_connection
    end
    it 'finds the entry by its id' do
      entry = subject.class.find(6088105)
      expect(entry).to be_a Letsfreckle::Client::Entry
    end
    it 'returns a NoEntry if not found' do
      expect(subject.class.find(-1)).to be_a Letsfreckle::Client::NoEntry
    end
    it 'finds entries by a given filter' do
      expect(subject.class.find_by(description: 'test').first).to be_a Letsfreckle::Client::Entry
    end
    it 'returns an empty array if no entries match' do
      expect(subject.class.find_by(description: 'some probably non-existing entry name')).to eql([])
    end
    it 'has a project' do
      expect(subject.class.find(6088105).project).to be_a Letsfreckle::Client::Project
    end
    it 'can be marked as invoiced' do
      entry = Letsfreckle::Client::Entry.find_by(invoiced: false).first
      expect(entry.mark_as_invoiced).to eql(true)
    end
    it 'creates a new entry' do
      entry = Letsfreckle::Client::Entry.new
      entry.user_id = 5543
      entry.minutes = 60
      entry.description = "#support test #{Time.now.to_i}"
      entry.project_id = 8475
      expect(entry.save).to eql(true)
      expect(entry.id).to be > 0
    end
    it 'updates an existing entry' do
      entry = Letsfreckle::Client::Entry.new
      entry.user_id = 5543
      entry.minutes = 60
      entry.description = "#support test"
      entry.project_id = 8475
      expect(entry.save).to eql(true)
      description = entry.description + Time.now.to_i.to_s
      entry_id = entry.id
      entry.description = description
      expect(entry.save).to eql(true)
      expect(Letsfreckle::Client::Entry.find(entry_id).description).to eql(description)
      expect(entry.delete).to eql(true)
    end
  end
end
