require 'csv'

namespace :seed_from_csv do
  desc "delete data and reset primary key sequence"
  task destroy: :environment do
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Merchant.destroy_all
    Customer.destroy_all

    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    puts "All records have been destroyed and primary keys reset."
  end

  desc "seed customers"
  task customers: :environment do
    file = "./db/csv_seeds/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      Customer.create(row.to_h)
    end

    puts "Seeded #{Customer.all.count} customers."
  end

  desc "seed invoice items"
  task invoice_items: :environment do
    file = "./db/csv_seeds/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
      if row["unit_price"]
        row["unit_price"] = (row["unit_price"].to_f / 100).round(2)
      end
      InvoiceItem.create(row.to_h)
    end

    puts "Seeded #{InvoiceItem.all.count} invoice items."
  end

  desc "seed invoices"
  task invoices: :environment do
    file = "./db/csv_seeds/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      Invoice.create(row.to_h)
    end

    puts "Seeded #{Invoice.all.count} invoices."
  end

  desc "seed items"
  task items: :environment do
    file = "./db/csv_seeds/items.csv"
    CSV.foreach(file, headers: true) do |row|
      if row["unit_price"]
        row["unit_price"] = (row["unit_price"].to_f / 100).round(2)
      end
      Item.create(row.to_h)
    end

    puts "Seeded #{Item.all.count} items."
  end

  desc "seed merchants"
  task merchants: :environment do
    file = "./db/csv_seeds/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      Merchant.create(row.to_h)
    end

    puts "Seeded #{Merchant.all.count} merchants."
  end

  desc "seed transactions"
  task transactions: :environment do
    file = "./db/csv_seeds/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      Transaction.create(row.to_h)
    end

    puts "Seeded #{Transaction.all.count} transactions."
  end

  task :all => [:destroy, :customers, :merchants, :items, :invoices, :invoice_items, :transactions]
end
