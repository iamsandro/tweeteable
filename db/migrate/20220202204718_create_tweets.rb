class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets do |t|
      t.string :body
      t.integer :replies_count, default: 0
      t.integer :likes_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_reference :tweets, :replied_to, foreign_key: { to_table: :tweets }
  end
end
