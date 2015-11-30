module ApplicationHelper
  def navbar_item(name, path, active = false)
    content_tag :li, class: (active ? "active" : "inactive") do
      link_to name, path
    end
  end

  def admin_navbar_item(name, path, active = false)
    navbar_item(name, path, active = false) if logged_in?
  end

  def login_navbar_item
    if logged_in?
      content_tag :li, class: "logout navbar-text" do
        logout_link = link_to("Logout", logout_path, method: :delete)
        "Signed in as #{ current_user.name } (#{ logout_link })".html_safe
      end
    else
      navbar_item("Login", login_path, controller_path =~ /sessions/)
    end
  end

  def render_message(type = :notice)
    if flash[type]
      content_tag :p, id: type.to_s do
        flash[type]
      end
    end
  end
end
