class Review < ActiveRecord::Base
  paginates_per 5
  belongs_to :site
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :rating,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5,
      only_integer: true
    }


  validates :user, presence: true
  validates :site, presence: true
end
