class ChangeTransactionsResultColumnToString < ActiveRecord::Migration[5.2]
  def change
    change_table :transactions do |t|
      t.change :result, :string
    end
  end
end
