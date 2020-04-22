class ConfigsController < ApplicationController
  def edit
    @config = current_user.config
  end

  def update
    @config = current_user.config
    if @config.update_attributes(config_params)
      flash[:success] = 'updated!'
    else
      flash[:danger] = 'not updated!'
    end
    redirect_to edit_config_path
  end

  private

  def config_params
    params.require(:config).permit(
      :direction,
      :show,
      :black_list,
      :bubble
    )
  end
end
