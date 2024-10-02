class List < ApplicationRecord
  include UserAttributable
  has_many :wishlist_items
end
