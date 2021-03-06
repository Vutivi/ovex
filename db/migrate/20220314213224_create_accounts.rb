class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :member, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.float :balance, null: false, default: 0.0
      t.float :locked, null: false, default: 0.0

      t.timestamps
    end
  end
end
