class User < ActiveRecord::Base
  
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  #validates :name,  presence: true , length: { minimum:3 , maximum:50}
  validates :name, :presence => { message: "alanını boş bırakamazsınız!"} ,
      length:{ minimum:3, maximum:30 , message:"minimum 3, maximum 30 karakterden oluşmalıdır."}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence => { message: "alanını boş bırakamazsınız!"}, 
      format: { with: VALID_EMAIL_REGEX , message:"formatı hatalı. Örnek: mail@example.com"}, uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password ,length: { minimum: 6 , maximum:15, message:"minimum 6, maximum 15 karakterden oluşmalıdır."}
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
 
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
    
end
