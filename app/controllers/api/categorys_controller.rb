class Api::CategorysController < ApplicationController

  layout :false

  def select_child
    @category = Category.find(params[:cat]).children
  end
end