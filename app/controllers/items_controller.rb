class ItemsController < ApplicationController
  def sell
    @prefectures = Prefecture.all
  end

  def deteal

  end
end
