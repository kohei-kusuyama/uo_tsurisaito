class Public::UsersController < ApplicationController
  def show
    @user = current_user
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
  end
end


private

def user_params
  params.require(:user).permit(:last_name, :first_name,  :delivery_area, :email, :active, :nickname, :introduction, :profile_image, :back_image)
end