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
    MascotRelationship.create(user_id: current_user.id, mascot_id: params[:id], default_animation: 'idle')
    redirect_to collection_path
  end

  def collection
    @mascots = current_user.mascots
  end

  def main
    @user = User.find_by(main_string: params[:id])
    render layout: 'main_mascot'
  end

  def set_main
    current_user.mascotRelationships.main&.update_attribute(:is_main, false)
    current_user.mascotRelationships.find_by(mascot_id: params[:id]).update_attribute(:is_main, true)

    redirect_to collection_path
  end

  private

  def mascot_params
    params.require(:mascot).permit(:name, :message, :price_money, :price_points, animations: [])
  end
end
