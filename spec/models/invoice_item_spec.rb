require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it {should have_many(:merchants).through(:item)}
    it {should have_many(:discounts).through(:merchants)}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
  end

  describe '#instance_methods' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Billy the Guy")
      @merchant_2 = Merchant.create!(name: "Different Guy")
      @merchant_3 = Merchant.create!(name: "Christian")
      @merchant_4 = Merchant.create!(name: "Braxton")
      @merchant_5 = Merchant.create!(name: "Alastair")
      @merchant_6 = Merchant.create!(name: "Anthony")
  
      @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
      @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
      @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
      @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
      @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
      @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")
      @customer_7 = Customer.create!(first_name: "Donald", last_name: "Duck")
      @customer_8 = Customer.create!(first_name: "Goofy", last_name: "Dog")
  
      @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: '2001-01-01 00:00:00')
      @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2002-01-01 00:00:00')
      @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: '2003-01-01 00:00:00')
      @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: '2004-01-01 00:00:00')
      @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2005-01-01 00:00:00')
      @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_6.id, created_at: '2006-01-01 00:00:00')
      @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_7.id, created_at: '2007-01-01 00:00:00')
      @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: '2008-01-01 00:00:00')
      @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2009-01-01 00:00:00')
      @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_2.id, created_at: '2010-01-01 00:00:00')
      @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_3.id, created_at: '2011-01-01 00:00:00')
      @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_4.id, created_at: '2012-01-01 00:00:00')
      @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2013-01-01 00:00:00')
      @invoice_14 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2014-01-01 00:00:00')
      @invoice_15 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2015-01-01 00:00:00')
      @invoice_16 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2016-01-01 00:00:00')
      @invoice_17 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2017-01-01 00:00:00')
      @invoice_18 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2018-01-01 00:00:00')
      @invoice_19 = Invoice.create!(status: 1, customer_id: @customer_5.id, created_at: '2019-01-01 00:00:00')
      @invoice_20 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2020-01-01 00:00:00')
      @invoice_21 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2021-01-01 00:00:00')
      @invoice_22 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2022-01-01 00:00:00')
      @invoice_23 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '2023-01-01 00:00:00')
      @invoice_24 = Invoice.create!(status: 1, customer_id: @customer_8.id, created_at: '1999-01-01 00:00:00')
  
      @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
      @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)
      @item_3 = Item.create!(name: "Digimon Cards", description: "What are these again?", unit_price: 300, merchant_id: @merchant_3.id, status: 1)
      @item_4 = Item.create!(name: "Magic 8 Ball", description: "Fortune Telling", unit_price: 2000, merchant_id: @merchant_4.id, status: 1)
      @item_5 = Item.create!(name: "Stretch Armstrong", description: "Stretchy", unit_price: 100, merchant_id: @merchant_5.id, status: 1)
      @item_6 = Item.create!(name: "Yu-Gi-Oh Cards", description: "It's time to duel", unit_price: 1000, merchant_id: @merchant_6.id, status: 1)
      @item_7 = Item.create!(name: "Things", description: "Things", unit_price: 300, merchant_id: @merchant_1.id, status: 1)
      @item_8 = Item.create!(name: "Soccer Ball", description: "Kick it", unit_price: 2000, merchant_id: @merchant_1.id, status: 1)
      @item_9 = Item.create!(name: "keyboard", description: "Type", unit_price: 100, merchant_id: @merchant_1.id, status: 1)
      @item_10 = Item.create!(name: "Hot Sauce", description: "It's hot", unit_price: 1000, merchant_id: @merchant_1.id, status: 1)
      @item_11 = Item.create!(name: "Barbie Dream House", description: "Barbie Time", unit_price: 4000, merchant_id: @merchant_1.id, status: 1)
  
      @ii_1 = InvoiceItem.create!(quantity: 10, unit_price: 800, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
      @ii_2 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
      @ii_3 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
      @ii_4 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
      @ii_5 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
      @ii_6 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
      @ii_7 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_7.id)
      @ii_8 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_8.id)
      @ii_9 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_9.id)
      @ii_10 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_10.id)
      @ii_11 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_11.id)
      @ii_12 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_12.id)
      @ii_13 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_13.id)
      @ii_14 = InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_14.id) 
      @ii_15 = InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_15.id) 
      @ii_16 = InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_3.id, invoice_id: @invoice_16.id) 
      @ii_17 = InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_4.id, invoice_id: @invoice_17.id) 
      @ii_18 = InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_5.id, invoice_id: @invoice_18.id) 
      @ii_19 = InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_6.id, invoice_id: @invoice_19.id) 
      @ii_20 = InvoiceItem.create!(quantity: 5, unit_price: 3500, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_20.id)
      @ii_21 = InvoiceItem.create!(quantity: 5, unit_price: 4500, status: "shipped", item_id: @item_8.id, invoice_id: @invoice_21.id)
      @ii_22 = InvoiceItem.create!(quantity: 5, unit_price: 6500, status: "shipped", item_id: @item_9.id, invoice_id: @invoice_22.id)
      @ii_23 = InvoiceItem.create!(quantity: 5, unit_price: 5500, status: "shipped", item_id: @item_10.id, invoice_id: @invoice_23.id)
      @ii_24 = InvoiceItem.create!(quantity: 5, unit_price: 7500, status: "shipped", item_id: @item_11.id, invoice_id: @invoice_24.id)
      
      @transaction_1 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_1.id)
      @transaction_2 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_2.id)
      @transaction_3 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_3.id)
      @transaction_4 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_4.id)
      @transaction_5 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_5.id)
      @transaction_6 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_6.id)
      @transaction_7 = Transaction.create!(credit_card_number: "4654407418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_7.id)
      @transaction_8 = Transaction.create!(credit_card_number: "4653405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_8.id)
      @transaction_9 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_9.id)
      @transaction_10 = Transaction.create!(credit_card_number: "4654435418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_10.id)
      @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_11.id)
      @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
      @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
      @transaction_14 = Transaction.create!(credit_card_number: "4654405418249633", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_14.id)
      @transaction_15 = Transaction.create!(credit_card_number: "4654405418249635", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_15.id)
      @transaction_16 = Transaction.create!(credit_card_number: "4654405418249636", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_16.id)
      @transaction_17 = Transaction.create!(credit_card_number: "4654405418249637", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_17.id)
      @transaction_18 = Transaction.create!(credit_card_number: "4654405418249638", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_18.id)
      @transaction_19 = Transaction.create!(credit_card_number: "4654405418249639", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_19.id)
      @transaction_20 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_20.id)
      @transaction_21 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_21.id)
      @transaction_22 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_22.id)
      @transaction_23 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_23.id)
      @transaction_24 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "success", invoice_id: @invoice_24.id)
  
      @discount_1 = Discount.create!(name: "Sale Time", threshold: 10, percentage: 20, merchant_id: @merchant_1.id)
      @discount_2 = Discount.create!(name: "Labor Day Sale", threshold: 10, percentage: 25, merchant_id: @merchant_1.id)
      @discount_3 = Discount.create!(name: "Holiday Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
      @discount_4 = Discount.create!(name: "Halloween Sale", threshold: 15, percentage: 20, merchant_id: @merchant_1.id)
      @discount_5 = Discount.create!(name: "Christmas Sale", threshold: 15, percentage: 30, merchant_id: @merchant_1.id)
      @discount_6 = Discount.create!(name: "Buy it", threshold: 20, percentage: 35, merchant_id: @merchant_2.id)
  
    end
    describe '#return_discounts' do
      it 'will return the discounts for that items merchant' do
        expect(@ii_1.return_discount).to eq(@discount_2)
      end
    end

    describe '#discounted_revenue' do
      it 'returns the discounted revenue if a discount applies' do
        expect(@ii_1.discounted_revenue).to eq(6000)
      end
    end

    describe "#full_revenue" do
      it 'calculates the full revenue of an invoice item' do
        expect(@ii_1.full_revenue).to eq(8000)
      end
    end
  end
end