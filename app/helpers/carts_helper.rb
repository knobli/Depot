module CartsHelper
  
  def current_cart
    Cart.find(session[:id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end    
  
end