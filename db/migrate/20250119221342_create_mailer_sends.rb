class CreateMailerSends < ActiveRecord::Migration[8.0]
  def change
    create_table :mailer_sends do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :sent_at
    end
  end
end
