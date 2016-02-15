class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :rating, :presence => true, :numericality => {greater_than: 0, less_than: 6}
  validates :comment, :presence => true
  validates :book_id, :presence => true, :numericality => true
  validates :user_id, :presence => true, :numericality => true
end
