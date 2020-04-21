class User < ApplicationRecord
  has_one :mascotCollection, dependent: :destroy
  has_one :config, dependent: :destroy
  has_many :commands, dependent: :destroy
  has_many :mascots, through: :mascotCollection do
    def main
      where('isMain = ?', true)
    end
  end

  has_one_attached :avatar
end
