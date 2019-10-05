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
    if cat_size
      @sizes = cat_size.children
    else
      return 0
    end
  end

end