class AddSaltToUser < ActiveRecord::Migration
  def change
  	add_column :users, :salt, :float
  	add_column :users, :password_digest, :string
  	User.reset_column_information
  	User.all.each do |user|
  		user.salt = Random.new().rand()
  		user.password_digest = Digest::SHA1.hexdigest(user.login + user.salt.to_s)
  		user.save
  	end
  end
end
