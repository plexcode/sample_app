module ApplicationHelper

  # the purpose of this block is to provide a default title if the
  # instance variable @title is not populated
  def title
     base_title = "Ruby on Rails Tutorial Sample App"
     if @title.nil?
       base_title
     else
       "#{base_title} | #{@title}"
     end
  end
  
end
