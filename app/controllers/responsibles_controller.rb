class ResponsiblesController < ApplicationController
  def index
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @responsibles = Responsible.paginate(page: params[:page], per_page: 5)
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
        @responsible = Responsible.new
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
        @responsible = Responsible.new(responsible_params)
        @responsible.id_assistant = SecureRandom.uuid
        if @responsible.valid?
          @responsible.save
          flash[:notice] = 'data asisten tersimpan'
          redirect_to responsibles_path
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
      if session[:user_role] == 'ROLE_ADMIN'
        @responsible = Responsible.find(params[:id])
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  def update
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @responsible = Responsible.find(params[:id])
        if @responsible.update(responsible_params)
          flash[:notice] = 'data asisten berhasil diubah'
          redirect_to responsibles_path
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
      if session[:user_role] == 'ROLE_ADMIN'
        @responsible = Responsible.find(params[:id])
        @responsible.destroy
        redirect_to responsibles_path
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  private

  def responsible_params
    params.require(:responsible).permit(:name, :phone)
  end
end
