class PracticumsController < ApplicationController
  def index
    @practicums = Practicum.all
  end

  def new
    @practicum = Practicum.new
  end

  def create
    @practicum = Practicum.new(practicum_params)
    @practicum.id_practicum = SecureRandom.uuid
    if @practicum.valid?
      @practicum.save
      flash[:notice] = 'data praktikum berhasil disimpan'
      redirect_to practicums_path
    else
      render 'new'
    end
  end

  def edit
    @practicum = Practicum.find(params[:id])
  end

  def update
    @practicum = Practicum.find(params[:id])

    if @practicum.update(practicum_params)
      redirect_to practicums_path
    else
      render 'edit'
    end
  end

  def destroy
    @practicum = Practicum.find(params[:id])
    @practicum.destroy
    redirect_to practicums_path
  end

  private

  def practicum_params
    params.require(:practicum).permit(:practicum_name)
  end
end
