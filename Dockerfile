FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile* ./
RUN bundle install
ADD . /myapp
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
