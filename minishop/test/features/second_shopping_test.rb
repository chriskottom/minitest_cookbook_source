require "test_helper"

feature "Shopping v2" do
  scenario "add several items to the cart and check out" do
    # Go to the store's homepage
    visit root_path
    within("#cart") do
      expect(page).must_have_css(".contents", text: "Your cart is empty.")
      expect(page).must_have_css(".total_line .price", text: "$0.00")
    end

    # Add the first item to the cart.
    add_to_cart_buttons = page.all('.entry_list .entry input[value="Add to Cart"]')
    add_to_cart_buttons.first.click
    expect(page).must_have_css("#cart .line_item", count: 1)

    # Add the last item to the cart.
    add_to_cart_buttons.last.click
    expect(page).must_have_css("#cart .line_item", count: 2)

    # Check out.
    find_button("Checkout").click
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
