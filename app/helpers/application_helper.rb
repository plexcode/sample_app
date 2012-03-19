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

  # purpose of this block is to define the href of the logo
  # and make it available as a method in the app
  def logo
      logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
end
