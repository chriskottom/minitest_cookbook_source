class OrderExtractsController < ApplicationController
  def create
    OrderExtractJob.perform_later
    respond_to do |format|
      format.html do
        redirect_back fallback_location: orders_url,
                      notice: "Your extract is now being generated and sent."
      end
    end
  end
end
