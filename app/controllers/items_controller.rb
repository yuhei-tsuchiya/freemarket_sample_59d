class ItemsController < ApplicationController
  def sell
    @prefectures = Prefecture.all
  end
end
