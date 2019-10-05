class Api::CategorysController < ApplicationController

  layout :false

  def select_child
    @category = Category.find(params[:cat]).children
    @count = params[:count]
    @flag = params[:flag].to_i
    # binding.pry
  end
end