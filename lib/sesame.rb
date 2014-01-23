require 'sesame/version'
require 'sesame/errors'
require 'digest/sha1'

module Sesame
  class << self
    NONSENSE = '552233432sdffsdsdeseretbookisgreat'
    
    def generate_key
      Digest::SHA1.hexdigest(self.name + Time.now.to_s)
    end

    def generate_token
      Digest::SHA1.hexdigest(self.name + NONSENSE + Time.now.to_f.to_s)
    end

    def authenticate_request(signature, timestamp, token)
      raise ArgumentError, 'all arguments must have a value' if !signature || !timestamp || !token
      raise RequestError, 'stale request' if (Time.now.to_i - timestamp.to_i) > 600
      raise RequestError, 'invalid signature' if !self.valid_signature?(signature, timestamp, token)
      true
    end

    def valid_signature?(signature, timestamp, token)
      signature.downcase == Digest::SHA1.hexdigest(timestamp.to_s + token)
    end

  end
end
