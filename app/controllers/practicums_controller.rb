class PracticumsController < ApplicationController
  def index
    if session[:user_role]
      if session[:user_role] == 'ROLE_ADMIN'
        @practicums = Practicum.paginate(page: params[:page], per_page: 5)
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
        @practicum = Practicum.new
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
        @practicum = Practicum.new(practicum_params)
        @practicum.id_practicum = SecureRandom.uuid
        if @practicum.valid?
          @practicum.save
          flash[:notice] = 'data praktikum berhasil disimpan'
          redirect_to practicums_path
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
        @practicum = Practicum.find(params[:id])
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
        @practicum = Practicum.find(params[:id])
        if @practicum.update(practicum_params)
          redirect_to practicums_path
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
        @practicum = Practicum.find(params[:id])
        @practicum.destroy
        redirect_to practicums_path
      else
        redirect_to '/403'
      end
    else
      redirect_to '/login'
    end
  end

  private

  def practicum_params
    params.require(:practicum).permit(:practicum_name)
  end
end
