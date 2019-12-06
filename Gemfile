source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # デバッグ用
  gem 'pry-rails'
  # 自動デプロイ用Capistrano関連のGemをインストール
  gem 'capistrano', '= 3.11.1'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'

  # binding.pry
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'

  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'factory_bot_rails'

end


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keepuni
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


# 本番環境用gemファイル
group :production do
  gem 'unicorn', '5.4.1'
end

# ユーザー管理機能及びビュー作成
gem 'devise'
gem 'haml-rails'

# AWS S3設定に伴いimageuploader導入
gem 'carrierwave'
gem 'fog-aws'
gem 'mini_magick'

# Font Awesome導入
gem 'font-awesome-rails'

# 都道府県データ処理用
gem 'active_hash'

# jQeury

gem 'jquery-rails'

#多階層構造
gem 'ancestry'

# メッセージの日本語化
gem 'rails-i18n'

#ダミーデータ
gem 'faker'

# SNS認証関係
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem 'dotenv-rails'

#パンくず
gem "gretel"

# クレジットカード機能
gem 'payjp'

# 商品検索用
gem 'ransack'
