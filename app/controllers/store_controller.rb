class StoreController < ApplicationController

def pose_count
  if session[:counter].nil?
    session[:counter] = 0
  end
  session[:counter] += 1
end

  def index
    @count = pose_count
    @products = Product.order(:title)
  end

end
