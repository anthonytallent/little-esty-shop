class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    
    if @item.update(item_params)
      if params[:status]
        @item.change_status
        redirect_to merchant_items_path(@item.merchant)
      else
        redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
        flash[:message] = 'Item updated'
      end
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:error] = 'Update invalid'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(name: params[:name],
                                description: params[:description],
                                unit_price: params[:unit_price])

    if @item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:error] = 'Required content missing'
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end