FROM ruby:3.2.2-alpine

RUN apk add \
  build-base \
  tzdata \
  nodejs

WORKDIR /home/app

ENV PORT 3000

COPY Gemfile* .
RUN bundle install

COPY . .

EXPOSE $PORT

CMD ["rails", "server", "-b", "0.0.0.0"]
