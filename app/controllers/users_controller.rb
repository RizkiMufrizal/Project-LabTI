class UsersController < ApplicationController
  def index
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @users = User.paginate(page: params[:page], per_page: 5)
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def new
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @user = User.new
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def create
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @user = User.new(user_params)
        if @user.valid?
          @user.save
          flash[:notice] = 'anda berhasil membuat data user'
          redirect_to users_path
        else
          render 'new'
        end
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def destroy
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        email = params[:id]
        @user = User.find("#{email}.com")
        @user.destroy
        redirect_to users_path
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_hash)
  end
end
