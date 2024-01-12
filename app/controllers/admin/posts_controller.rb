class Admin::PostsController < ApplicationController
  # def index
  #   @posts = Post.all
  #   @post = Post.new
  # end

  # def show
  #   @post = Post.find(params[:id])
  #   @user = @post.user
  #   @post_comment = PostComment.new
  #   @post_comments = @post.post_comments.order('created_at DESC').limit(5)
  # end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to posts_path
  end

  private
    def if_not_admin
      redirect_to root_path unless current_user.admin?
  　end

    def set_post
      @post = Post.find(params[:id])
    end
    end
end
