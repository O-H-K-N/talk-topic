module ApplicationHelper
  def page_title(page_title = '')
    base_title = t('defaults.tab_browser.app_name')

		page_title.empty? ? base_title : page_title + " | " + base_title

  end
end
