module MainMascotHelper
  def my_main(user)
    default_animation = user.mascotRelationships.main.default_animation

    current_animation = user.mascots.main.animations.select do |animation|
      animation.blob.filename == "#{animation.record.name}_#{default_animation}.gif"
    end

    image_tag(url_for(current_animation[0]))
  end
end
