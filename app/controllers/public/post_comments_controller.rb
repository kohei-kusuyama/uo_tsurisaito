class Public::PostCommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.all
    @post_comment = PostComment.new
  end

  def create
    @post = Post.find(params[:post_id])
    content = current_user.post_comments.new(post_comment_params)
    content.post_id = @post.id
    content.save
    @post_comments = @post.post_comments.order('created_at DESC').limit(5)

    # redirect_to request.referer
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content)
  end

end
