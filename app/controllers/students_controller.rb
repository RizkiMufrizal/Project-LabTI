class StudentsController < ApplicationController
  def index
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @students = Student.paginate(page: params[:page], per_page: 5)
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.valid?
      @student.save
      if session[:user_role]
        flash[:notice] = 'anda berhasil membuat data mahasiswa'
        redirect_to '/'
      else
        flash[:notice] = 'anda berhasil melakukan register, silahkan login'
        redirect_to '/login'
      end
    else
      render 'new'
    end
  end

  def edit
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @student = Student.find(params[:id])
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def editBiodata
    if session[:user_role]
      if session[:user_role] == 'ROLE_MAHASISWA'
        @student = Student.find(session[:user_role])
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  end

  def update
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @student = Student.find(params[:id])
        if @student.update(student_params)
          flash[:notice] = 'data mahasiswa berhasil diubah'
          redirect_to students_path
        else
          render 'edit'
        end
      elsif session[:user_role] == 'ROLE_MAHASISWA'
        @student = Student.find(params[:id])
        if @student.update(student_params)
          flash[:notice] = 'anda berhasil mengubah biodata anda'
          redirect_to '/'
        else
          render 'editBiodata'
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
        @student = Student.find(params[:id])
        @student.destroy
        redirect_to students_path
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  private

  def student_params
    params.require(:student).permit(:npm, :name, :class_name, :gender, :address, :password_hash)
  end
end
