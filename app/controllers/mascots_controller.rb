class MascotsController < ApplicationController
  def index
    @mascots = Mascot.all
  end
end