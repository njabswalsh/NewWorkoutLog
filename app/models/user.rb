class User < ActiveRecord::Base
	has_many :posts
	has_and_belongs_to_many :teams
	validates :login, presence: true

	def password_valid? password
		digest = Digest::SHA256.hexdigest(password + self.salt.to_i.to_s)
		return digest == self.password_digest
	end

	def User.create first_name, last_name, login, password
		if password == ""
			return false
		end
		salt = Random.new().rand(2147483647)
		password_digest = Digest::SHA256.hexdigest(password + salt.to_s)
		user = User.new(:first_name => first_name, :last_name => last_name, :login => login.downcase, :salt => salt, :password_digest => password_digest)
		user.save
	end

end
