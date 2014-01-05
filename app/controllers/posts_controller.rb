#Controller class for  announcements 
class PostsController < ApplicationController

	before_action :signed_in_user, only: [:show, :index]
  before_action :admin_user, only: [:create, :update, :edit, :new, :destroy]
#Contoller method for creating announcements page
	def new
	  @post = Post.new
	end
	
#Controller method for creating new announcements
	def create
	  @post = Post.new(params[:post].permit(:title, :text))
	
	  if @post.save
	    redirect_to @post
	  else
	    render 'new'
	  end
	end	
	
#Controller method for showing announcements
	def show
	  @post = Post.find(params[:id])
	end
	
#Controller method for showing index of announcement page
	def index
	  @posts = Post.all.order('created_at DESC')
	  @post = Post.new
	end
	
#Controller method for opening edit page of the announcements
	def edit
	  @post = Post.find(params[:id])
	end
	
#Controller method for updating the announcement
	def update
	  @post = Post.find(params[:id])
	 
	  if @post.update(params[:post].permit(:title, :text))
	    redirect_to @post
	  else
	    render 'edit'
	  end
	end
	
#Contoller method for for deleting the announcement
	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy
	
	  redirect_to posts_path
	end
	
	private
	  def post_params
		params.require(:post).permit(:title, :text)
	  end
	
	
end
