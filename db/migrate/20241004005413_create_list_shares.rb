class CreateListShares < ActiveRecord::Migration[8.0]
  def change
    create_table :list_shares, id: false do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :share_type, default: 0
      t.references :list, null: false, foreign_key: true
      t.references :shared_with, null: true, foreign_key: { to_table: :users }
      t.string :id, null: false, primary_key: true

      t.timestamps
    end

    add_index :list_shares, :id, unique: true
  end
end
