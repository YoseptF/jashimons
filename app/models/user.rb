class User < ApplicationRecord
  has_many :mascotRelationships, dependent: :destroy
  has_one :config, dependent: :destroy
  has_many :commands, dependent: :destroy
  has_many :mascots, through: :mascotRelationships do
    def main
      where('isMain = ?', true)
    end
  end

  has_one_attached :avatar
end
