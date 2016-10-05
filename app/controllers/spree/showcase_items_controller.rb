class Spree::Admin::ShowcaseItemsController < ApplicationController
  before_filter :find_showcase_item, only: [:show, :edit, :update, :destroy]

  def index
    @showcase_items = ShowcaseItem.all
  end

  def show
    
  end

  def new
    @showcase_item = ShowcaseItem.new
  end

  def edit
  end

  def create
    @showcase_item = ShowcaseItem.new(params[:showcase_item])
  end

  def update
    if @showcase_item.update_attributes(params[:showcase_item])
      flash[:notice] = 'ShowcaseItem was successfully updated.'
      redirect_to(@showcase_item)
    else
      render :edit
    end
  end

  # DELETE /showcase_items/1
  # DELETE /showcase_items/1.xml
  def destroy
    @showcase_item.destroy
    redirect_to(showcase_items_url)
  end

  private
    def showcase_item_params
      params.require(:message).permit(:front_page)
    end
    
    def find_showcase_item
      @showcase_item = ShowcaseItem.find(params[:id])
    end

end
