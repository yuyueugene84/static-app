class User < ActiveRecord::Base
	attr_accessor :remember_token

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

	  # Returns the hash digest of the given string.
  	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

  	  # Returns a random token.
  	def User.new_token
    	SecureRandom.urlsafe_base64
  	end

  	  # Remembers a user in the database for use in persistent sessions.
  	def remember
    	self.remember_token = User.new_token
    	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	  # Returns true if the given token matches the digest.
  	def authenticated?(remember_token)
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	  # Forgets a user.
  	def forget
    	update_attribute(:remember_digest, nil)
  	end

end
