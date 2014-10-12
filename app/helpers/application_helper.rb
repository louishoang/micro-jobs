module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize

    # add css class to make arrow up and down
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    #direction of sort
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}, {class: css_class}
  end
end
