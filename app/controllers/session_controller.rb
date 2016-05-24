class SessionController < ApplicationController
  def login
  end

  def process_login
    @user = User.authenticate(params[:email], params[:password])
    if @user
      if @user.enable == true
        if @user.role = 'ROLE_USER'
          session[:user_name] = @user.name
          session[:user_id] = @user.id
          session[:user_email] = @user.email
          session[:user_login] = true
          session[:user_role] = @user.role
          redirect_to '/'
        else
          flash[:notice] = 'Anda berhasil login'
          session[:user_name] = @user.name
          session[:user_id] = @user.id
          session[:user_email] = @user.email
          session[:user_login] = true
          session[:user_role] = @user.role
          redirect_to '/'
        end
      else
        flash[:danger] = 'anda belum melakukan registrasi'
        render 'login'
      end
    else
      flash[:danger] = 'anda belum melakukan registrasi'
      render 'login'
    end
  end

  def logout
    flash[:notice] = 'Anda berhasil logout'
    session[:user_name] = nil
    session[:user_email] = nil
    session[:user_login] = false
    redirect_to action: 'login'
  end
end
