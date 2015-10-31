module SortableHelper
  def sort_link(name, path, active_param)
    css_class = "btn btn-default "
    css_class = css_class + "active" if params[:sort] == active_param
    link_to name, path, class: css_class
  end
end
