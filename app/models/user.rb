class User < ApplicationRecord
  has_many :mascotRelationShips, dependent: :destroy
  has_one :config, dependent: :destroy
  has_many :commands, dependent: :destroy
  has_many :mascots, through: :mascotRelationShips do
    def main
      where('isMain = ?', true)
    end
  end
end
