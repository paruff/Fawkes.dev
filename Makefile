RUBY = /usr/local/opt/ruby/bin/ruby
GEM  = /usr/local/opt/ruby/bin/gem
PATH := /usr/local/opt/ruby/bin:$(PATH)

build:
	$(GEM) install bundler --conservative 2>/dev/null; bundle exec jekyll build

serve:
	$(GEM) install bundler --conservative 2>/dev/null; bundle exec jekyll serve --livereload
