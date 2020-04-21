class Mascot < ApplicationRecord
  has_one_attached :defaultAnimation
  has_many_attached :animations
end
