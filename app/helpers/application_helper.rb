module ApplicationHelper

  def controller_active?(name)
    controller_name.to_s == name.to_s ? true : false
  end

  def li_active(controller_name)
    controller_active?(controller_name) ? 'active' : ''
  end

  def active_menu(controller_name)
    controller_active?(controller_name) ? active_spam : ''
  end

  def active_spam
    content_tag :span, '(current)', class: 'sr-only'
  end

  def page_header(elements)
    border = content_tag :hr, '', class: 'my-4'
    capture do
      concat border
      elements.each do |e|
        concat content_tag e[:name], e[:title], class: e[:class]
      end
      concat border
    end
  end

end
