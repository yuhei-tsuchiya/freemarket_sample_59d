class Api::CategorysController < ApplicationController

  layout :false

  def select_child
    @category = Category.find(params[:cat]).children
    @cat_id = params[:cat_id]
    @flag = params[:flag].to_i
    # binding.pry
  end

  def display_size
    cat_size = Category.find(params[:cat]).size
    @have_brand = Category.find(params[:cat]).have_brand
    if cat_size
      @sizes = cat_size.children
    else
      return 0
    end
  end

  def select_burden
    @burden = Burden.find(params[:burden]).children
  end

  def search_brand
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

end