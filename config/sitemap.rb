# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://mamapapa-qa.com"

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily', priority: 0.9
  Question.where(status: [Question.statuses[:open], Question.statuses[:done]]).each{|q|
    add question_path(q.hashid), lastmod: q.updated_at, priority: 0.8
  }

  add tag_path('妊活'), changefreq: 'daily', priority: 0.7
  add tag_path('妊娠'), changefreq: 'daily', priority: 0.7
  add tag_path('出産'), changefreq: 'daily', priority: 0.7
  add tag_path('赤ちゃん'), changefreq: 'daily', priority: 0.7
  add tag_path('子育て'), changefreq: 'daily', priority: 0.7
end