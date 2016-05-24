class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.valid?
      @student.save
      flash[:notice] = 'anda berhasil melakukan register, silahkan login'
      redirect_to '/login'
    else
      render 'new'
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])

    if @student.update(student_params)
      flash[:notice] = 'anda berhasil mengubah biodata anda'
      redirect_to students_path
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

  private

  def student_params
    params.require(:student).permit(:npm, :name, :class_name, :gender, :address, :password_hash)
  end
end
