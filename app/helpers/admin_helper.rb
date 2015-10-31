module AdminHelper
  def breadcrumb(name, path, active=false)
    content_tag(:li) do
      link_to name, path
    end
  end

  def breadcrumb_active(name)
    content_tag(:li, name, class: 'active')
  end
end
