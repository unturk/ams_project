class Renter < ActiveRecord::Base
  
  before_save :set_defaults
  validates :name, :presence => { message: "alanını boş bırakamazsınız!"}, 
            length: { minimum:3 , maximum:30 , message: "minimum 3, maximum 30 karakterden oluşmalıdır."}
  validates :ap_num, :presence => { message: "alanını boş bırakamazsınız!"}, uniqueness: { message: " zaten alınmış."}
  validates :phone, :presence => { message: "alanını boş bırakamazsınız!"},
            length: { minimum:11, maximum:11, message:"numarası 11 haneden oluşmalıdır.(4 haneli alan kodlarını dahil ediniz.)" }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, :presence => { message: "alanını boş bırakamazsınız!"}, 
      format: { with: VALID_EMAIL_REGEX , message:"formatı hatalı. Örnek: mail@example.com"}, 
      uniqueness: { case_sensitive: false, message:"daha önce kullanılmış" }

  private
    def set_defaults
      self.email = email.downcase
      self.ocak = "0"
      self.subat = "0"
      self.mart = "0"
      self.nisan = "0"
      self.mayis = "0"
      self.haziran = "0"
      self.temmuz = "0"
      self.agustos = "0"
      self.eylul = "0"
      self.ekim = "0"
      self.kasim = "0"
      self.aralik = "0"
    end
end
