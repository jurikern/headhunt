module ApplicationHelper
  def go_to_top_link
    content_tag :div, class: 'pull-right' do
      link_to '#top', onclick: 'function(){window.scroll(); return false;}' do
        raw t('button.go_to_top') + ' &#8593;'
      end
    end
  end
end
