class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.post
    favorite_post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids)
  end

  def my_page
    @user = current_user
    @posts = @user.post
    favorite_post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids)
    render :show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "変更が完了いたしました"
      redirect_to users_my_page_path
    else
      @user = current_user
      render :edit
    end
  end

  def check
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(status: 1)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  # def favorites
  #   @user = User.find(params[:id])
  #   favorite_post_ids = Favorite.where(user_id: @user.id).pluck(:post_id)
  #   @favorite_posts = Post.where(id: favorite_post_ids)
  # end
end


private

def user_params
  params.require(:user).permit(:last_name, :first_name,  :delivery_area, :email, :active, :nickname, :introduction, :profile_image, :back_image)
end