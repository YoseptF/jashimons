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
      p 'yay', mascot_params
    else
      p 'nay', mascot_params
    end
  end

  private

  def mascot_params
    params.require(:mascot).permit(:name, :message, :priceMoney, :pricePoints, animations: [])
  end
end
