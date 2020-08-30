class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :invoice
      t.string :credit_card_number
      t.date :credit_card_expiration_date
      t.integer :result, default: 0

      t.timestamps
    end
  end
end
