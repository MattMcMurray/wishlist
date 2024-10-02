class AddListToWishlistItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :wishlist_items, :list, null: false, foreign_key: true
  end
end
