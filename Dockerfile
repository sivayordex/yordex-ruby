FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /myapp
RUN mkdir /gem
ADD /gem/yordex.gemspec /gem
ADD /gem/yordex-0.0.1.gem /gem
WORKDIR /myapp
ADD /yordex-ruby/Gemfile /myapp/Gemfile
ADD /yordex-ruby/Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
