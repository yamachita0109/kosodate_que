module ApplicationHelper
  include Pagy::Frontend

  def site_title(page_title = '')
    base_title = 'パパママQA'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def site_description(page_description = '育児をしているパパママ必見の質問と回答のコミュニティサイトです。育児の悩みや疑問に答えたり、自分の育児の経験を共有したりできます。')
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
