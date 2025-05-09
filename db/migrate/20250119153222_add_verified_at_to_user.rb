class AddVerifiedAtToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :verified_at, :datetime, default: nil
  end
end
