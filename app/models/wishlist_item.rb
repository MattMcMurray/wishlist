class WishlistItem < ApplicationRecord
  include UserAttributable
  belongs_to :list
end
