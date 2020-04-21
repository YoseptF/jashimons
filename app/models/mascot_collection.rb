class MascotCollection < ApplicationRecord
  belongs_to :user
  has_many :mascotRelationships, primary_key: 'user_id', foreign_key: 'user_id'
  has_many :mascots, through: :mascotRelationships do
    def main
      where('isMain = ?', true)
    end
  end
end
