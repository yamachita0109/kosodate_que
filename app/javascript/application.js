// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"

import 'dist/main'
import 'dist/question/show/main'
import 'dist/question/edit/main'
import 'dist/question/new/main'
import 'dist/mypage/show/main'
import 'dist/profile/show/main'