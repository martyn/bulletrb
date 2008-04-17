module SimpleMenubarHelper

  # simple_menubar creates a list of links for your menu.  
  # It determines which item is selected by checking the current_page.
  # Options:
  # Usage: = simple_menubar(["Home", "/index.html"], ["Documentation", "/docs.html"]]) 
  #
  # Fill in the selected for li.current in your stylesheet.
  # Ex:
  # li.current a {
  #   background-color: #551B1F;
  # }
  def simple_menubar(pages)
    inner_ul = ""
    pages.each do |title, url|
      next_page = tag(:li) {link(title, url)}
      if(current_page == url)
        next_page = tag(:li, :class => "current") {link(title, url)}
      end
      inner_ul += next_page
    end
    tag(:ul) { inner_ul }
  end

end
