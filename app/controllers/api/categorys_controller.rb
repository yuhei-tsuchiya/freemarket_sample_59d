class Api::CategorysController < ApplicationController

  layout :false

  def select_child
    @category = Category.find(params[:cat]).children
    @cat_id = params[:cat_id]
    @flag = params[:flag].to_i
    # binding.pry
  end
end