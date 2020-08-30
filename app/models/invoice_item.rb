class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice
  belongs_to :customer
  has_many :transactions
end
