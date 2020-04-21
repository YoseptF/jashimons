module MascotsHelper
  def animation_name(animation)
    animation.blob.filename_in_database.scan(/\_([a-z]*)\./i).first.first
  end

  def animation_states(animations)
    animations.collect do |animation|
      [animation_name(animation), url_for(animation)]
    end
  end

  def first_state(animations)
    image_tag(url_for(animations.first), class: 'card-img-top', alt: 'Card image cap') 
  end
end
