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
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :post_image, :category, :point, :size)
    end

end