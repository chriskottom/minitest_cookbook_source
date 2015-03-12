class LineItemsController < ApplicationController
  skip_before_action   :authorize

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find(line_item_params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_path, notice: 'Line item was successfully created.' }
        format.js   { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id)
  end
end
