class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items

  validates_uniqueness_of :title
end
