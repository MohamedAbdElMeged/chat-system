class GenerateApplicationTokenHelper
  def self.create_token
    SecureRandom.base58(24)
  end
end
