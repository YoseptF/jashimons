class User < ApplicationRecord
  has_many :mascotRelationships, dependent: :destroy do
    def main
      where('is_main = ?', true).take
    end
  end
  has_one :config, dependent: :destroy
  has_many :commands, dependent: :destroy
  has_many :mascots, through: :mascotRelationships do
    def main
      where('is_main = ?', true).take
    end
  end

  has_one_attached :avatar
end
