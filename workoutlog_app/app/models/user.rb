class User < ActiveRecord::Base
	
	def password_valid? password
		digest = Digest::SHA1.hexdigest(password + self.salt.to_s)
		return digest == self.password_digest
	end

	def User.create first_name, last_name, login, password
		salt = Random.new().rand()
		password_digest = Digest::SHA1.hexdigest(password + salt.to_s)
		user = User.new(:first_name => first_name, :last_name => last_name, :login => login, :salt => salt, :password_digest => password_digest)
		user.save
	end

end
