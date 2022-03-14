class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.references :member, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.float :amount, null: false
      t.float :fee, null: false
      t.string :aasm_state, null: false

      t.timestamps
    end
  end
end
