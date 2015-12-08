# coding: utf-8
require "test_helper"

feature "Shopping v3" do
  scenario "add several items to the cart and check out", js: true do
    # Go to the store's homepage.
    visit root_path
    within("#cart") do
      expect(page).must_have_css(".contents", text: "Your cart is empty.")
      expect(page).must_have_css(".total_line .price", text: "$0.00")
    end

    # Add the first item to the cart.
    entries = page.all(".entry_list .entry")
    entry1, entry2 = entries.first, entries.last
    id1, id2 = [ entry1, entry2 ].map { |e| e[:id].sub(/entry_/, "") }
    product1, product2 = Product.find(id1), Product.find(id2)

    within(entry1) do
      click_button("Add to Cart")
    end

    within("#cart .current_item") do
      expect(page).must_have_css(".quantity", text: "1×")
      expect(page).must_have_css(".title", text: product1.title)
      expect(page).must_have_css(".price",
                                 text: sprintf("$%.2f", product1.price))
    end

    expect(page).must_have_css("#cart .total_line .price",
                               text: sprintf("$%.2f", product1.price))

    # Add the last item to the cart.
    within(entry2) do
      click_button("Add to Cart")
    end

    within("#cart .current_item") do
      expect(page).must_have_css(".quantity", text: "1×")
      expect(page).must_have_css(".title", text: product2.title)
      expect(page).must_have_css(".price",
                                 text: sprintf("$%.2f", product2.price))
    end

    expected_total = product1.price + product2.price
    expect(page).must_have_css("#cart .total_line .price",
                               text: sprintf("$%.2f", expected_total))

    # Check out.
    find("#cart").find_button("Checkout").click

    within("form#new_order") do
      fill_in("Name", with: "Bill Lumbergh")
      fill_in("Address", with: "123 Shady Tree Lane")
      fill_in("Email", with: "da_boss@initech.com")
      select("Purchase Order", from: "Pay type")
      click_button("Create Order")
    end

    # See the order confirmed.
    within("#cart") do
      expect(page).must_have_css(".contents", text: "Your cart is empty.")
      expect(page).must_have_css(".total_line .price", text: "$0.00")
    end

    expect(page).must_have_css("#notice", text: "Thank you for your order.")
  end
end
