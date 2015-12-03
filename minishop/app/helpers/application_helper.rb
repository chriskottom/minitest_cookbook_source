module ApplicationHelper
  # Truncates the text to a sentence boundary if one is available within half
  # the total maximum length. Otherwise truncates to the nearest word boundary.
  def smart_truncate(text, options = {})
    length = options[:length]
    return text if text.length <= length

    result = truncate_sentence(text, options)
    if result.length <= length/2
      result = text.truncate(length, separator: /\b/,
                             omission: "...", escape: false)
    end
    result
  end

  # Truncate to the nearest sentence boundary.
  def truncate_sentence(text, options = {})
    sentence_break = text.rindex(/[\.\?\!]/, options[:length])
    sentence_break ? text[0, sentence_break++1] : ""
  end

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

  def render_errors_for(model, model_name = nil)
    if model.errors.any?
      model_name ||= model.class.name.humanize.downcase
      render partial: "shared/errors", locals: { model: model, name: model_name }
    end
  end
end
