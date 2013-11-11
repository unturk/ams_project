module ApplicationHelper
  
   #returns the full title on per-page basis
  def full_title(page_title)
    base_title = "AYS"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
