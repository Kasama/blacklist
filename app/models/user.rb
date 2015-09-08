class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessor :password_confirmation
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def authenticate(password)
    if self && self.password_hash == BCrypt::Engine.hash_secret(password, self.password_salt)
      self
    else
      nil
    end
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    user.authenticate(password)
  end

  private
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret password, self.password_salt
    end
  end

end
