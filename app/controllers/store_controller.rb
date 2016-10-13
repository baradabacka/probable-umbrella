class StoreController < ApplicationController
  skip_before_action :authorize
  include CurrentCart
  before_action :set_cart

def pose_count
  if session[:counter].nil?
    session[:counter] = 0
  end
  session[:counter] += 1
end

  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @count = pose_count
      @products = Product.order(:title)
    end
  end

end
