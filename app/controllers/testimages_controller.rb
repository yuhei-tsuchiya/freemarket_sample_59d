class TestimagesController < ApplicationController
  def index
    @testimage = "hello world"
  end

  def cretate
    Testimages.create(image: testimage_params[:image])
    # binding.pry
  end

  private
  def testimage_params
    params.permit(:image)
  end

end
