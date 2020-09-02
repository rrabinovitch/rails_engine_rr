class ChangeTransactionsResultDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:transactions, :result, from: "0", to: nil)
  end
end
