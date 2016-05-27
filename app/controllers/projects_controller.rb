class ProjectsController < ApplicationController
  def index
    @projects = Project.select('practicums.*, projects.*, students.*, responsibles.*')
                       .joins('INNER JOIN practicums
                               ON practicums.id_practicum = projects.practicum_id_practicum
                               INNER JOIN students
                               ON students.npm = projects.student_npm
                               INNER JOIN responsibles
                               ON responsibles.id_assistant = projects.responsibles_id_assistant')
                       .paginate(page: params[:page], per_page: 5)
  end

  def indexStudent
    if session[:user_role]
      if session[:user_role] == 'ROLE_MAHASISWA'
        @projects = Project.select('practicums.*, projects.*, students.*, responsibles.*')
                           .joins('INNER JOIN practicums
                                   ON practicums.id_practicum = projects.practicum_id_practicum
                                   INNER JOIN students
                                   ON students.npm = projects.student_npm
                                   INNER JOIN responsibles
                                   ON responsibles.id_assistant = projects.responsibles_id_assistant')
                           .where(student_npm: session[:user_npm])
                           .paginate(page: params[:page], per_page: 5)
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def new
    @project = Project.new
  end

  def create
    if session[:user_role]
      if session[:user_role] == 'ROLE_MAHASISWA'
        name_file = params[:project][:name_file]

        file_extension = File.extname(name_file.original_filename)
        new_file_name = SecureRandom.uuid

        File.open(Rails.root.join('public', 'uploads', "#{new_file_name}#{file_extension}"), 'wb') do |file|
          file.write name_file.read
        end

        @project = Project.new(project_params)
        @project.id_project = SecureRandom.uuid
        @project.name_file = "#{new_file_name}#{file_extension}"
        @project.student_npm = session[:user_npm]
        if @project.valid?
          @project.save
          flash[:notice] = 'data project berhasil disimpan'
          redirect_to projects_path
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

  def edit
    if session[:user_role]
      if session[:user_role] == 'ROLE_MAHASISWA'
        @project = Project.find(params[:id])
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def update
    if session[:user_role]
      if session[:user_role] == 'ROLE_MAHASISWA'
        @project = Project.find(params[:id])

        if @project.update(project_params)
          redirect_to projects_path
        else
          render 'edit'
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
      if session[:user_role] == 'ROLE_MAHASISWA'
        @project = Project.find(params[:id])
        @project.destroy
        redirect_to projects_path
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name_project, :name_file, :practicum_id_practicum, :responsibles_id_assistant)
  end
end
