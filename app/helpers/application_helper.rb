module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      quote: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def popup(partial_path, id='popup')
    content_tag :div, class: 'popup', id: id do
      content_tag :div, class: 'backdrop' do
        content_tag :div, class: 'boxWrapper' do
          content_tag :div, class: 'box' do
            link_to('close', '', class: 'boxClose') + render(partial_path)
          end
        end
      end
    end
  end

  def login_popup_class
    current_user ? '' : ' loginPopupLink'
  end

  def displayed_datestamp(datetime)
    content_tag(:time, distance_of_time_in_words_to_now(datetime) + " ago", datetime: datetime)
  end

  def displayed_created_at(datetime)
    content_tag(:time, datetime.strftime("%B %e, %Y"), datetime: datetime)
  end
end
