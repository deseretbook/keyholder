require 'spec_helper'

describe '.generate_key' do

  it 'should generate a key' do
    expect(Sesame.generate_key).to_not be_nil
  end
end

describe '.generate_token' do

  it 'should generate a token' do
    expect(Sesame.generate_token).to_not be_nil
  end

end

describe '.authenticate_request' do

  it 'should raise an ArgumentError if not all parameters have a value' do
    expect(lambda { Sesame.authenticate_request('hello', Time.now, nil) }).to raise_error(ArgumentError)
  end

  it 'should raise a RequestError if the request timestamp is too old' do
    token = 'hello'
    timestamp = Time.now
    signature = Digest::SHA1.hexdigest(timestamp.to_s + token)
    expect(lambda { Sesame.authenticate_request(signature, timestamp - 700, token) }).to raise_error(/stale request/)
  end

  it 'should raise a RequestError if the signature is invalid' do
    token = 'hello'
    timestamp = Time.now
    signature = Digest::SHA1.hexdigest(timestamp.to_s + 'world')
    expect(lambda { Sesame.authenticate_request(signature, timestamp, token) }).to raise_error('invalid signature')
  end

end
