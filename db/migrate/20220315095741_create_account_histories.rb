class CreateAccountHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :account_histories do |t|
      # t.references :account, null: false, foreign_key: true
      t.float :balance, null: false
      t.float :locked, null: false
      t.integer :event, default: 0
      t.float :change_amount, null: false
      t.references :loggable, polymorphic: true

      t.timestamps
    end
  end
end
