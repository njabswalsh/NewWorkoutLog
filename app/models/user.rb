class User < ActiveRecord::Base
	
	def password_valid? password
		digest = Digest::SHA256.hexdigest(password + self.salt.to_i.to_s)
		puts "SALT: " + self.salt.to_i.to_s
		puts "DIGEST: " + digest
		puts "PASSWORD DIGEST: " + self.password_digest
		return digest == self.password_digest
	end

	def User.create first_name, last_name, login, password
		salt = Random.new().rand(2147483647)
		puts "NEWLY CREATED SALT: " + salt.to_s
		password_digest = Digest::SHA256.hexdigest(password + salt.to_s)
		user = User.new(:first_name => first_name, :last_name => last_name, :login => login, :salt => salt, :password_digest => password_digest)
		user.save
	end

end
