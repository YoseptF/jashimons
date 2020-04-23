class CommandsController < ApplicationController
  def show
    @commands = current_user.commands
  end

  def edit
    if params[:id].nil?
      new_command = current_user.commands.build(command_params)
      if new_command.save
        flash[:success] = 'new command added'
      else
        flash[:danger] = "command wasn't added"
        p new_command.errors
      end
    else
      if current_user.commands.include?(Command.find(params[:id]))
        Command.find(params[:id]).update_attributes(command_params)
        flash[:success] = 'success'
      else
        flash[:danger] = "you don't own that command... how dare you?!"
      end
    end

    redirect_to commands_path
  end

  def command_params
    params.require(:command).permit(
      :name,
      :message,
      :animation_name,
      :animation_type,
      :duration,
      :cooldown,
      :isEnabled
    )
  end
end
