module ApplicationHelper
  include Pagy::Frontend

  def site_title(page_title = '')
    base_title = 'ママパパQ&A'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def site_description(page_description = 'ママとパパが育児に関する悩みや問題を解決するためのQ&Aサイト。ユーザー同士での相互支援や専門家からのアドバイスにより、育児に関する悩みを共有し解決策を見つけることができます。')
    if page_description.length > 120
      page_description[0...120] + "..."
    else
      page_description
    end
  end

  def site_keywords(page_keywords = '子育て,育児,質問,相談')
    page_keywords
  end

end
