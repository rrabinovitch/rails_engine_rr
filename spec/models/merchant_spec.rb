require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe 'methods' do
    it '::most_revenue' do
      merch_1, merch_2, merch_3, merch_4, merch_5 = create_list(:merchant, 5)

      item_1 = create(:item, merchant: merch_1, unit_price: 10)
      item_2 = create(:item, merchant: merch_2, unit_price: 10)
      item_3 = create(:item, merchant: merch_3, unit_price: 10)
      item_4 = create(:item, merchant: merch_4, unit_price: 10)
      item_5 = create(:item, merchant: merch_5, unit_price: 10)

      inv_1 = create(:invoice, merchant: merch_1)
      inv_2 = create(:invoice, merchant: merch_2)
      inv_3 = create(:invoice, merchant: merch_3)
      inv_4 = create(:invoice, merchant: merch_4)
      inv_5 = create(:invoice, merchant: merch_5)
      inv_6 = create(:invoice, merchant: merch_1)
      inv_7 = create(:invoice, merchant: merch_2, status: "pending")

      inv_it_1 = create(:invoice_item, item: item_1, invoice: inv_1, quantity: 5, unit_price: item_1.unit_price)
      inv_it_2 = create(:invoice_item, item: item_2, invoice: inv_2, quantity: 4, unit_price: item_2.unit_price)
      inv_it_3 = create(:invoice_item, item: item_3, invoice: inv_3, quantity: 3, unit_price: item_3.unit_price)
      inv_it_4 = create(:invoice_item, item: item_4, invoice: inv_4, quantity: 2, unit_price: item_4.unit_price)
      inv_it_5 = create(:invoice_item, item: item_5, invoice: inv_5, quantity: 1, unit_price: item_5.unit_price)
      inv_it_6 = create(:invoice_item, item: item_1, invoice: inv_6, quantity: 1, unit_price: item_1.unit_price)
      inv_it_7 = create(:invoice_item, item: item_2, invoice: inv_7, quantity: 1, unit_price: item_2.unit_price)

      trns_1 = create(:transaction, invoice: inv_1)
      trns_2 = create(:transaction, invoice: inv_2)
      trns_3 = create(:transaction, invoice: inv_3)
      trns_4 = create(:transaction, invoice: inv_4)
      trns_5 = create(:transaction, invoice: inv_5, result: "failed")
      trns_6 = create(:transaction, invoice: inv_6)
      trns_7 = create(:transaction, invoice: inv_7)

      quantity = 3

      expect(Merchant.most_revenue(quantity)).to eq([merch_1, merch_2, merch_3])
    end
  end
end
