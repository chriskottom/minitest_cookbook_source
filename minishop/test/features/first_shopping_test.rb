require "test_helper"

feature "Shopping v1" do
  scenario "add several items to the cart and check out" do
    # Go to the store's homepage
    visit root_path
    expect(page).must_have_content("Your cart is empty.")
    expect(page).must_have_content("Total: $0.00")

    # Add the first item to the cart.
    add_to_cart_buttons = page.all('input[value="Add to Cart"]')
    add_to_cart_buttons.first.click

    # Add the last item to the cart.
    add_to_cart_buttons.last.click

    # Check out.
    find_button("Checkout").click
    fill_in("Name", with: "Bill Lumbergh")
    fill_in("Address", with: "123 Shady Tree Lane")
    fill_in("Email", with: "da_boss@initech.com")
    select("Purchase Order", from: "Pay type")
    click_button("Create Order")

    # See the order confirmed.
    expect(page).must_have_content("Your cart is empty.")
    expect(page).must_have_content("Total: $0.00")
    expect(page).must_have_content("Thank you for your order.")
  end
end
