require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  setup do
    @text =<<-EOF.squish
      You want to enjoy life, don't you? If you get your job done
      quickly and your job is fun, that's good isn't it?
    EOF
  end

  test "#navbar_item can create an inactive nav item" do
    expected = '<li class="inactive"><a href="bar/bat">Foo</a></li>'
    assert_equal expected, navbar_item("Foo", "bar/bat")
  end

  test "#navbar_item can create an active nav item" do
    expected = '<li class="active"><a href="bar/bat">Foo</a></li>'
    assert_equal expected, navbar_item("Foo", "bar/bat", true)
  end
end
