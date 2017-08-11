FROM ruby:2.3
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs
RUN mkdir -p /myapp
WORKDIR /myapp
COPY yordex-ruby/Gemfile /myapp
COPY yordex-ruby/Gemfile.lock /myapp
RUN gem install bundler && bundle install --jobs 20 --retry 5
COPY yordex-ruby/. /myapp
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
