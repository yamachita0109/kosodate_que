module ApplicationHelper
  include Pagy::Frontend

  def site_title(page_title = '')
    base_title = 'ママパパQ&A'
    return base_title if page_title.empty?
    "#{base_title} | #{page_title}"
  end

  def site_description(page_description = '')
    base_description = 'ママとパパが育児に関する悩みや問題を解決するためのQ&Aサイト。ユーザー同士での相互支援やアドバイスにより、育児に関する悩みを共有し解決策を見つけることができます。'
    return base_description if page_description.empty?

    if page_description.length > 120
      page_description[0...120] + "..."
    else
      page_description
    end
  end

  def site_keywords(page_keywords = '')
    base_keywords = '子育て,育児,質問,相談'
    return base_keywords if page_keywords.empty?
    page_keywords
  end

  def site_type(page_type = '')
    base_type = 'article'
    return base_type if page_type.empty?
    page_type
  end

end
