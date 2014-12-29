require 'spec_helper'
describe Letsfreckle::Client::Configuration do
  subject { Letsfreckle::Client::Configuration.new}
  before do
    subject.name = 'name'
    subject.token = 'token'
  end
  it 'has a token' do
    expect(subject.token).to eql('token')
  end
  it 'has a name' do
    expect(subject.name).to eql('name')
  end
  it 'is valid with both a name and token' do
    expect(subject.valid?).to eql(true)
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject.valid?).to eql(false)
    subject.name = ''
    expect(subject.valid?).to eql(false)
  end
  it 'is not valid without a token' do
    subject.token = nil
    expect(subject.valid?).to eql(false)
    subject.token = ''
    expect(subject.valid?).to eql(false)
  end
end


