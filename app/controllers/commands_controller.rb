class CommandsController < ApplicationController
  def edit
    @commands = current_user.commands
  end

  def show
    user = User.includes(:commands).find_by(main_string: params[:id])
    json_commands = {}
    user.commands.each do |command|
      json_commands[command['name']] = {
        id: command['id'],
        animation_type: command['animation_type'],
        animation_name: command['animation_name'],
        cooldown: command['cooldown'],
        created_at: command['created_at'],
        updated_at: command['updated_at'],
        duration: command['duration'],
        isEnabled: command['isEnabled'],
        message: command['message'],
        user_id: command['user_id'],
      }
    end
    json_animations = {}
    user.mascots.main.animations.each do |anim|
      name = anim.blob['filename'].match(/\_(.*)\./)
      blob = rails_blob_path(anim.blob, only_path: true)
      json_animations[name[1]] = blob
    end
    render json: { user: user, configs: json_commands, mainAnimation: json_animations }
  end

  def create
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

    redirect_to edit_commands_path
  end

  private

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
