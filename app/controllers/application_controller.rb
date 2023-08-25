class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :sort_field, :sort_direction, :default_sort_direction

  def sort_field
    "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:sort_direction]) ?  params[:sort_direction].downcase : default_sort_direction
  end

  def default_sort_direction
    "asc"
  end

  def sort_sql
    "#{sort_field} #{sort_direction}"
  end

end
