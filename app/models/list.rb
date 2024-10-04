class List < ApplicationRecord
  include UserAttributable
  has_many :wishlist_items, dependent: :destroy
  has_many :list_shares, dependent: :destroy
end
