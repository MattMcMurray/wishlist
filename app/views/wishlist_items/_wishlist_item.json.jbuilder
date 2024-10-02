json.extract! wishlist_item, :id, :url, :title, :description, :created_at, :updated_at
json.url wishlist_item_url(wishlist_item, format: :json)
