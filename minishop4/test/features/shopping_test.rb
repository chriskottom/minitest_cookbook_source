# -*- coding: utf-8 -*-
require "test_helper"

feature "Shopping" do
  scenario "add several items to the cart and check out", js: true do
    # Go to the store's homepage
    visit root_path
    cart_must_be_empty

    # Add the first item to the cart.
    entries = page.all(".entry_list .entry")

    product1 = product_for_entry(entries.first)
    add_to_cart(entries.first, product1)
    total_price_must_be(product1.price)

    # Add the last item to the cart.
    product2 = product_for_entry(entries.last)
    add_to_cart(entries.last, product2)
    total_price_must_be(product1.price + product2.price)

    # Check out.
    complete_order

    # See the order confirmed.
    cart_must_be_empty
    page.must_have_css("#notice", text: "Thank you for your order.")
  end

  def cart_must_be_empty
    within("#cart") do
      page.must_have_css(".contents", text: "Your cart is empty.")
      page.must_have_css(".total_line .price", text: "$0.00")
    end
  end

  def product_for_entry(entry)
    id = entry[:id].sub(/entry_/, "")
    Product.find(id)
  end

  def add_to_cart(entry, product = nil)
    product ||= product_for_entry(entry)

    within(entry) do
      click_button("Add to Cart")
    end

    within("#cart .current_item") do
      page.must_have_css(".quantity", text: "1×")
      page.must_have_css(".title", text: product.title)
      page.must_have_css(".price", text: sprintf("$%.2f", product.price))
    end

    product
  end

  def total_price_must_be(amount)
    page.must_have_css("#cart .total_line .price",
                       text: sprintf("$%.2f", amount))
  end

  def complete_order
    find("#cart").find_button("Checkout").click

    within("form#new_order") do
      fill_in("Name", with: "Bill Lumbergh")
      fill_in("Address", with: "123 Shady Tree Lane")
      fill_in("Email", with: "da_boss@initech.com")
      select("Purchase Order", from: "Pay type")
      click_button("Create Order")
    end
  end
end
