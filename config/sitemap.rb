# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://papamamaqa.com"

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily', priority: 0.9
  Question.where(status: [Question.statuses[:open], Question.statuses[:done]]).each{|q|
    add question_path(q.hashid), lastmod: q.updated_at, priority: 0.8
  }
end