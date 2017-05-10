module HashHelper

  def self.generate_hash
    SecureRandom.hex
  end
end