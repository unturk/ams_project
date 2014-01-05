# Controller that users can sumbit email to admin.
class RequestsController < ApplicationController
  
  before_action :signed_in_user, only: [:index, :create]
  
#Contoller method for listing users  
	def index
	end
	
#Controller method for creating new user
	def create
		@name = params[:request_form][:name]
		@title = params[:request_form][:title]
		@text = params[:request_form][:text]
		if(@name == '' || @title == '' || @text == '')
		  flash.now[:error] = "Tüm alanları doldurmanız gerekli!"
		else
		  ModelMailer.new_request(@name, @title, @text).deliver
		  flash.now[:success] = "Yöneticiye istek/şikayetiniz mail olarak gönderildi."
		end
		render "index"
	end
end
