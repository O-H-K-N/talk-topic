module ApplicationHelper
  def page_title(page_title = '')
    base_title = t('defaults.tab_browser.app_name')

		page_title.empty? ? base_title : page_title + " | " + base_title

  end

  def default_meta_tags
    {
      site: '会話のネタ帳',
      title: '使える会話のネタを提供してください！',
      reverse: true,
      description: '様々な場面に応じて、役に立った会話のネタを共有しあうアプリ',
      keywords: '会話 話のネタ 飲み会 職場 オンライン 合コン',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
      }
    }
  end
end
