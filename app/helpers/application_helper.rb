module ApplicationHelper
  include Pagy::Frontend
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  


  # sorting bullshit goes here... 
  SORT_ICONS = {
    :generic => {:asc => ['fa-solid','arrow-up-wide-short'], :desc => ['fa-solid','arrow-down-wide-short']},
    :alpha => {:asc => ['fa-solid','arrow-up-a-z'], :desc => ['fa-solid','arrow-down-z-a']},
    :numeric => {:asc => ['fa-solid','arrow-up-1-9'], :desc => ['fa-solid','arrow-down-9-1']}
  }

  def opposite_direction(direction)
    return 'asc' if direction.downcase == 'desc'
    return 'desc' if direction.downcase == 'asc'
    ''
  end
    
  def sortable_link_for( field, text: field.to_s.humanize, class: "", type: :generic)
    if params.permit(:sort_field)[:sort_field] == field.to_s
      link_to params.merge(:sort_field => field.to_s, :sort_direction => opposite_direction(sort_direction)).permit(:sort_field, :sort_direction) do
        (text + " " + icon(SORT_ICONS[type][sort_direction.to_sym][0], SORT_ICONS[type][sort_direction.to_sym][1])).html_safe
      end
    else
      link_to params.merge(:sort_field => field.to_s, :sort_direction => 'asc').permit(:sort_field, :sort_direction) do
        (text + " " + icon('fa-solid', 'arrows-up-down')).html_safe
      end
    end
  end
  
end
