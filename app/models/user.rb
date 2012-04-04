# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	#use attr_accessor :password to create a virtual password attribute
	attr_accessor :password
	#only the following attributes are writeable from the outside:
	attr_accessible :name, :email, :password, :password_confirmation 

email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #name must not be blank, and cannot exceed 50 characters
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }

  #email must not be blank, must follow the email format, and is case insensitive
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

 #Password Validation (chapter 7.1)
 # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  #Encrypt password before user save (7.1)
  #register a callback
  before_save :encrypt_password

   #method to compare password given in form with password in database (7.2 & 7.2.3)
   # Return true if the user's password matches the submitted password.
	#It’s also important to note the use of the has_password? boolean. 
	#This ensures that the salt gets reset whenever the user changes his password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)
  end
  
	#returns user if password and username match (7.2.4)
   def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
   end
  private

    #method to perform encryption, gets called by before_save (7.1)
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      #the encrpyted_password attribute of the current user is the encryption of the password virtual attribute?
      self.encrypted_password = encrypt(password)
    end

    #gets called by encrypt_password (7.1 & 7.2.3)
    def encrypt(string)
	#store passwords with the timestamp first, then password (encrpyted)
      secure_hash("#{salt}--#{string}")
	#Since we’re inside the User class, Ruby knows that salt refers to the user’s salt attribute.
    end

    #7.2.3
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    #gets called by the encrypt method & make_salt method. This is the actual encryption/hashing (7.2.3)
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end

