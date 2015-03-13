require "test_helper"

feature "Shopping" do
  scenario "put several items in the cart and check out" do
    # Go to the store's homepage
    visit root_path
    within("#cart") do
      page.must_have_css(".contents", text: "Your cart is empty.");
      page.must_have_css(".total_line .price", text: "$0.00")
    end

    # Select the first item in the cart.
    entries = page.all(".entry")
    within(entries[0]) do
      
    end

    # Select the second item in the cart.

    # Select the first item in the cart again.

    # Check out.

  end
end
