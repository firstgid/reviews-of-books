class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many   :reviews

  validates :title, :presence => true
  validates :author, :presence => true
  validates :description, :presence => true, :length => {minimum: 5}
  validates :user_id, :presence => true, :numericality => true
  validates :category_id, :presence => true, :numericality => true

  has_attached_file :book_img, styles: {
    book_index: "200x250>", book_show: "325x475>"},
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\Z/
end
