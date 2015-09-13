module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.action_name}"
  end

  def page_title(name)
    content_for(:title) { name }
    content_tag('h1', name)
  end
end
