module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Docket Management - IveyLaw.org"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("main_title.png", :alt => "IveyLaw.org", :class => "round")
  end
end
