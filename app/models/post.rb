class Post < ActiveRecord::Base
	belongs_to :user
	has_many :exercises
	has_many :notes
end
