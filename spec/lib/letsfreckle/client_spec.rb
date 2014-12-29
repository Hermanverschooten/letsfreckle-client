require './lib/letsfreckle/client'

describe Letsfreckle::Client do
  it 'initializes' do
    Letsfreckle::Client.configure do
      token 'token'
      name 'my name'
    end
    expect(Letsfreckle::Client.configuration.name).to eql('my name')
    expect(Letsfreckle::Client.configuration.token).to eql('token')
  end
end
