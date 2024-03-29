class Public::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  # skip_before_action :authenticate_admin!, if: :admin_url
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tags = Vision.get_post_image(post_params[:post_image])
    # @post.score = Language.get_data(post_params[:body])
    @post.user_id = current_user.id
    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end

      flash[:notice] = "投稿が完了いたしました"
      redirect_to post_path(@post) #リダイレクト先は詳細（show）ページ
    else
      render :new #保存されない場合はnewにとどまる
    end
  end

  def index
    @posts = Post.all
    #@post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order('created_at DESC').limit(5)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tags = Vision.get_post_image(post_params[:post_image])
    @post.update(post_params)
    @post.tags.destroy_all
    tags.each do |tag|
      @post.tags.create(name: tag)
    end
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :post_image, :category, :point, :size, :address)
    end

end