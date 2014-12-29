require 'spec_helper'

describe Letsfreckle::Client do
  it 'initializes' do
    Letsfreckle::Client.configure do
      token 'token'
      name 'my name'
    end
    expect(Letsfreckle::Client.configuration.name).to eql('my name')
    expect(Letsfreckle::Client.configuration.token).to eql('token')
  end

  context 'connected' do
    before do
      setup_connection
    end
    it 'reads the entries' do
      response = subject.read('/projects')
      expect(response.success?).to eql(true)
      expect(response.count).to be > 0
    end
    it 'reads entries with a given filter' do
      response = subject.read('/entries', billable: true)
      expect(response.success?).to eql(true)
      puts response.count
      expect(response.count).to be > 0
    end
  end
end
