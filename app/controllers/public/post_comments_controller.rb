class Public::PostCommentsController < ApplicationController
  def index
    @post_comment = PostComment.all
  end

  def create
    @post = Post.find(params[:post_id])
    content = current_user.post_comments.new(post_comment_params)
    content.post_id = @post.id
    content.save
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
