class SessionController < ApplicationController
  def admin
  end

  def process_login_admin
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_name] = @user.name
      session[:user_email] = @user.email
      session[:user_login] = true
      session[:user_role] = @user.role
      redirect_to '/'
    else
      flash[:danger] = 'username dan password anda masih salah'
      render 'login'
    end
  end

  def login
  end

  def process_login_praktikan
    @student = Student.authenticate(params[:npm], params[:password])
    if @student
      session[:user_name] = @student.name
      session[:user_npm] = @student.npm
      session[:user_login] = true
      session[:user_role] = @student.role
      redirect_to '/'
    else
      flash[:danger] = 'username dan password anda masih salah'
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
