FROM ruby:2.7.2-alpine

ENV LANG C.UTF-8
ENV APP_ROOT /app
RUN apk update \
    && mkdir -p /myapp \
    && apk add --no-cache git \
    # build-base for native extensions
    build-base \
    mysql-client \
    mysql-dev \
    gcompat \
    # less is necessary for ruby console
    less \
    # bash is useful for development
    bash 
# create working directory
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]