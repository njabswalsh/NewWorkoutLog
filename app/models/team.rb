class Team < ActiveRecord::Base
	has_and_belongs_to_many :users

	def password_valid? password
		digest = Digest::SHA256.hexdigest(password + self.salt.to_i.to_s)
		return digest == self.password_digest
	end

	def Team.create name, password
		salt = Random.new().rand(2147483647)
		password_digest = Digest::SHA256.hexdigest(password + salt.to_s)
		team = Team.new(:name => name, :salt => salt, :password_digest => password_digest)
		team.save
	end
end
