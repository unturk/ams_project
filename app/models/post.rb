#Database model for announcements
class Post < ActiveRecord::Base
  validates :title, :presence => { message: "alanını boş bırakamazsınız!"},
            length: { minimum:5 , maximum:30 , message: "minimum 5, maximum 30 karakterden oluşmalıdır."}
  validates :text, :presence => { message: "alanını boş bırakamazsınız!"},
            length: { minimum:10 , maximum:360 , message: "minimum 10, maximum 360 karakterden oluşmalıdır."}
end
