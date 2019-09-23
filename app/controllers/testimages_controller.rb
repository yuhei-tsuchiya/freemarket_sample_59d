class TestimagesController < ApplicationController
  def index
    @test = "hello world"
    @testimage = Testimage.new
  end

  def create
    Testimage.create(image: testimage_params[:image])
    redirect_to testimages_path
  end

  private
  def testimage_params
    params.require(:testimage).permit(:image)
  end

end
