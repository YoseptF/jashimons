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

  def buy
    new_mascot = MascotRelationship.create(user_id:current_user.id,mascot_id: params[:id])
    redirect_to user_mascots_path
  end

  private

  def mascot_params
    params.require(:mascot).permit(:name, :message, :priceMoney, :pricePoints, animations: [])
  end
end
