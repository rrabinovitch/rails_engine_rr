class ChangeInvoicesStatusColumnToString < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.change :status, :string, default: nil
    end
  end
end
