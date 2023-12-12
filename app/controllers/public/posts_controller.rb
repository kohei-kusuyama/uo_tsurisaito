class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save

      flash[:notice] = "投稿が完了いたしました"
      redirect_to post_path(@post) #リダイレクト先は詳細（show）ページ
    else
      render :new #保存されない場合はnewにとどまる
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :post_image, :category, :point, :size)
    end

end