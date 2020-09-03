class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    Merchant.joins(invoices: :items).joins(invoices: :transactions)
      .select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end
end
