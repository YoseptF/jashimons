class MascotsController < ApplicationController
  def index
    @mascots = Mascot.all
  end

  def new
    @mascot = Mascot.new
  end

  def create
    @mascot = Mascot.new(mascot_params)

    if @mascot.save
      flash[:success] = 'Mascot created'
    else
      flash[:danger] = 'Mascot not created'
    end
    redirect_to new_mascot_path
  end

  private

  def mascot_params
    params.require(:mascot).permit(:name, :message, :priceMoney, :pricePoints, animations: [])
  end
end
