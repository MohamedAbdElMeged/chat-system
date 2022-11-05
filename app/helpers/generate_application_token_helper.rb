class GenerateApplicationTokenHelper
  def self.create_token
    token = SecureRandom.base58(24)
    token
  end
end
