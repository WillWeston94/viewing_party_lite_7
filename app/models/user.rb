class User < ApplicationRecord
  has_many :hosted_parties, -> { where(is_host: true) }, class_name: 'ViewingParty', foreign_key: 'user_id'
  has_many :invited_parties, -> { where(is_host: false) }, class_name: 'ViewingParty', foreign_key: 'user_id'
  has_many :viewing_parties, foreign_key: 'user_id'
  has_many :movies, through: :viewing_parties

  validates :name, presence: true
  validates :email, presence: true
end
