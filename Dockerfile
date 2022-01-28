FROM ruby:2.7.2

ENV LANG C.UTF-8
ENV APP_ROOT /app


# create working directory
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# bundle install
COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install --jobs 4 --retry 3 
# create app in container
COPY . $APP_ROOT

# script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process

CMD ["rails", "server", "-b", "0.0.0.0"]





