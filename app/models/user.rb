class User < ActiveRecord::Base
	before_save { email.downcase! }
	#before_save {self.email = email.downcase}
	#self means current user
	validates :name, presence: true, length: {maximum: 50}
	#check if the name is there, and the length of name is no more than 50

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	#A valid email regex that disallows double dots in email addresses

  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  	#check if email is there, and the format must be the same as REGEX, and the email must be unique 

  	has_secure_password
  	#The ability to save a securely hashed password_digest attribute to the database
	#A pair of virtual attributes17 (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match
	#An authenticate method that returns the user when the password is correct (and false otherwise)

	validates :password, length: {minimum: 6}

end
