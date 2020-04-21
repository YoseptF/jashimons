class MascotRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :mascot

  scope :mainMascot, -> { where('isMain = 1') }
end
