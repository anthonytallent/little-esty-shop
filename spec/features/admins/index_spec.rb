require 'rails_helper'

RSpec.describe 'admins dashboard' do
  before :each do
    @merchant_1 = Merchant.create!(name: "Billy the Guy")
    @merchant_2 = Merchant.create!(name: "Different Guy")

    @customer_1 = Customer.create!(first_name: "Steve", last_name: "Martin")
    @customer_2 = Customer.create!(first_name: "Tony", last_name: "Stark")
    @customer_3 = Customer.create!(first_name: "Henry", last_name: "Ford")
    @customer_4 = Customer.create!(first_name: "Randy", last_name: "Pepperoni")
    @customer_5 = Customer.create!(first_name: "Mark", last_name: "Bologna")
    @customer_6 = Customer.create!(first_name: "Anthony", last_name: "Tall")

    @invoice_1 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: Time.now - 3.days)
    @invoice_2 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 1, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_7 = Invoice.create!(status: 1, customer_id: @customer_1.id)
    @invoice_8 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_9 = Invoice.create!(status: 1, customer_id: @customer_2.id)
    @invoice_10 = Invoice.create!(status: 1, customer_id: @customer_3.id)
    @invoice_11 = Invoice.create!(status: 1, customer_id: @customer_5.id)
    @invoice_12 = Invoice.create!(status: 1, customer_id: @customer_6.id)
    @invoice_13 = Invoice.create!(status: 1, customer_id: @customer_6.id)

    @item_1 = Item.create!(name: "Pokemon Cards", description: "Investments", unit_price: 800, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Pogs", description: "Old school", unit_price: 500, merchant_id: @merchant_2.id)

    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: @invoice_1.id)
    InvoiceItem.create!(quantity: 1, unit_price: 800, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_2.id)
    InvoiceItem.create!(quantity: 2, unit_price: 1600, status: "pending", item_id: @item_1.id, invoice_id: @invoice_3.id)
    InvoiceItem.create!(quantity: 10, unit_price: 8000, status: "shipped", item_id: @item_1.id, invoice_id: @invoice_4.id)
    InvoiceItem.create!(quantity: 1, unit_price: 500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_5.id)
    InvoiceItem.create!(quantity: 5, unit_price: 2500, status: "shipped", item_id: @item_2.id, invoice_id: @invoice_6.id)
    
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
    @transaction_11 = Transaction.create!(credit_card_number: "4654405418259638", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_11.id)
    @transaction_12 = Transaction.create!(credit_card_number: "4654405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_12.id)
    @transaction_13 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: @invoice_13.id)
  end

  it 'shows the little esty shop header' do
    visit admin_index_path
    
    expect(page).to have_content("Little Esty Shop")
  end

  it 'shows header indicating that I am on the admin dashboard' do
    visit admin_index_path

      within("#admin_navbar") do
        expect(page).to have_content("Admin Dashboard")
        expect(page).to have_link('Merchants')
        expect(page).to have_link('Invoices')
      end
  end

  it 'contains links to the admin merchants index' do
    visit admin_index_path

    within("#admin_navbar") do
      click_link 'Merchants'
    end

    expect(current_path).to eq(admin_merchants_path)
  end

  it 'contains links to the admin invoices index' do
    visit admin_index_path
    
    within("#admin_navbar") do
      click_link 'Invoices'
    end

    expect(current_path).to eq(admin_invoices_path)
  end

  it 'contains the top 5 customers' do
    visit admin_index_path

    within("#top_customers") do
      expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
      expect(page).to_not have_content(@customer_6.first_name)
    end
  end

  it 'shows incomplete invoices' do
    visit admin_index_path

    within("#incomplete_invoices") do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_3.id}")
      expect(page).to_not have_content("Invoice ##{@invoice_2.id}")

      click_link "Invoice ##{@invoice_1.id}"

      expect(current_path).to eq(admin_invoice_path(@invoice_1))
    end
  end

  it 'shows the incomplete invoices ordered by the date oldest to newest' do
    invoice_14 = Invoice.create!(status: 1, customer_id: @customer_1.id, created_at: Time.now - 4.days)
    InvoiceItem.create!(quantity: 5, unit_price: 4000, status: "packaged", item_id: @item_1.id, invoice_id: invoice_14.id)
    transaction_14 = Transaction.create!(credit_card_number: "4554405418249699", credit_card_expiration_date: nil, result: "failed", invoice_id: invoice_14.id)

    visit admin_index_path

    within("#incomplete_invoices") do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Invoice ##{@invoice_3.id}")
      expect(page).to have_content("Invoice ##{invoice_14.id}")

      expect("#{invoice_14.id}").to appear_before("#{@invoice_1.id}")
      expect("#{@invoice_1.id}").to appear_before("#{@invoice_3.id}")
      expect("#{@invoice_3.id}").to_not appear_before("#{invoice_14.id}")
    end
  end
end