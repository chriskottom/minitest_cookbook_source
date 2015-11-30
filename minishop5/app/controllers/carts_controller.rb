class CartsController < ApplicationController
  skip_before_action   :authorize

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = current_cart
    @cart.empty!

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Cart was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end
end
