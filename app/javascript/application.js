// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"

import './dist/question/show/main.js'
import './dist/question/edit/main.js'
import './dist/question/new/main.js'
import './dist/mypage/show/main.js'