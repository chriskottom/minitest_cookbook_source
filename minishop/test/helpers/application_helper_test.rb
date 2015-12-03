require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @text =<<-EOF.squish
      You want to enjoy life, don't you? If you get your job done
      quickly and your job is fun, that's good isn't it?
    EOF
  end

  test "#smart_truncate returns the whole string when it's short enough" do
    result = smart_truncate(@text, length: 1000)
    assert_equal @text, result
  end

  test "#smart_truncate truncates to a sentence boundary when it can" do
    result = smart_truncate(@text, length: 50)
    assert_equal "You want to enjoy life, don't you?", result
  end

  test "#smart_truncate truncates to a word boundary when it must" do
    result = smart_truncate(@text, length: 25)
    assert_equal "You want to enjoy life...", result
  end

  test "#navbar_item can create an inactive nav item" do
    expected = '<li class="inactive"><a href="bar/bat">Foo</a></li>'
    assert_equal expected, navbar_item("Foo", "bar/bat")
  end

  test "#navbar_item can create an active nav item" do
    expected = '<li class="active"><a href="bar/bat">Foo</a></li>'
    assert_equal expected, navbar_item("Foo", "bar/bat", true)
  end

  test "#render_errors_for prints each error in the model" do
    product = Product.new
    refute product.valid?
    refute_empty product.errors

    render_errors_for(product)
    errors = product.errors
    assert_match /#{ errors.count } errors kept us from saving this product/,
                 rendered
    errors.full_messages.each do |msg|
      assert_match /#{ ERB::Util.html_escape(msg) }/, rendered
    end
  end

  test "#render_errors_for prints nothing for a valid model" do
    user = users(:milton)
    assert user.valid?
    assert_empty user.errors

    render_errors_for(user)
    assert_empty rendered
  end
end
