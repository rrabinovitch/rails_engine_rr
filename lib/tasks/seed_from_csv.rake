require 'csv'

namespace :seed_from_csv do
  desc "reset database"
  task reset: :environment do
    Rake::Task["db:drop"].execute
    Rake::Task["db:create"].execute
    Rake::Task["db:migrate"].execute

    puts "All records have been destroyed."
  end

  desc "seed customers"
  task customers: :environment do
    file = "./db/csv_seeds/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      Customer.create!(row.to_h)
    end

    puts "Seeded #{Customer.all.count} customers."
  end

  desc "seed invoice items"
  task invoice_items: :environment do
    file = "./db/csv_seeds/invoice_items.csv"
    CSV.foreach(file, headers: true) do |row|
      data = row.to_h
      if data["unit_price"]
        data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
      end
      InvoiceItem.create!(data)
    end

    puts "Seeded #{InvoiceItem.all.count} invoice items."
  end

  desc "seed invoices"
  task invoices: :environment do
    file = "./db/csv_seeds/invoices.csv"
    CSV.foreach(file, headers: true) do |row|
      Invoice.create!(row.to_h)
    end

    puts "Seeded #{Invoice.all.count} invoices."
  end

  desc "seed items"
  task items: :environment do
    file = "./db/csv_seeds/items.csv"
    CSV.foreach(file, headers: true) do |row|
      data = row.to_h
      if data["unit_price"]
        data["unit_price"] = (data["unit_price"].to_f / 100).round(2)
      end
      Item.create!(data)
    end

    puts "Seeded #{Item.all.count} items."
  end

  desc "seed merchants"
  task merchants: :environment do
    file = "./db/csv_seeds/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    puts "Seeded #{Merchant.all.count} merchants."
  end

  desc "seed transactions"
  task transactions: :environment do
    file = "./db/csv_seeds/transactions.csv"
    CSV.foreach(file, headers: true) do |row|
      Transaction.create!(row.to_h)
    end

    puts "Seeded #{Transaction.all.count} transactions."
  end

  desc "reset primary keys"
  task pk_reset: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end

    puts "Primary keys have been reset."
  end

  task :all => [:reset, :customers, :merchants, :items, :invoices, :invoice_items, :transactions, :pk_reset]
end
