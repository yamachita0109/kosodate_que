SitemapGenerator::Sitemap.default_host = "https://mamapapa-qa.com"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Question.where(status: [Question.statuses[:open], Question.statuses[:done]]).each{|q|
  #   add question_path(q), lastmod: q.updated_at, priority: 0.8
  # }
end