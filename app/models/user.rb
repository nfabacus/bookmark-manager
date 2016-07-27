require 'bcrypt'

class User
  include BCrypt
  include DataMapper::Resource

#  def password
  #  @password ||= BCrypt::Password.new(password_hash)
#  end

#  def password=(new_password)
#    @password = BCrypt::Password.create(new_password)
#    self.password_hash = @password
#  end
  property :id, Serial
  property :e_mail, String
  property :password_digest, String, length: 60

  def password=(my_password)
    self.password_digest = BCrypt::Password.create(my_password)
  end
end
