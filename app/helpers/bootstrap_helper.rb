module BootstrapHelper
  def bs_row
    content_tag(:div, class: "row") do
      yield
    end
  end

  def bs_column(num)
    content_tag(:div, class: "col-md-#{num} col-lg-#{num}") do
      yield
    end
  end
end
