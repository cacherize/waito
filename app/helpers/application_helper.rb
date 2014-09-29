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

  def popup(partial_path)
    content_tag :div, class: 'popup' do
      content_tag :div, class: 'backdrop' do
        content_tag :div, class: 'box' do
          render partial_path
        end
      end      
    end
  end
end
