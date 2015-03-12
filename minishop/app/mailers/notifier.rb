class Notifier < ApplicationMailer
  default   from: "Postman <postman@example.com>"


  def order_received(order)
    @order = order
    mail to: order.email, subject: "MiniShop Order Confirmation"
  end

  def order_shipped(order)
    @order = order
    mail to: order.email, subject: "Your MiniShop Order Has Shipped"
  end
end
