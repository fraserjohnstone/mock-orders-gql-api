FROM usertesting/ruby:3.0-buster

ENV APP_USER appuser
ENV APP_PATH /usr/src/app
ENV RAILS_ROOT $APP_PATH
ENV BUNDLE_PATH $APP_PATH/vendor/bundle
ENV GEM_HOME=$APP_PATH/vendor/bundle
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 4000

USER root

RUN set -ex \
  && apt-get update \
  && apt-get -y install --no-install-recommends \
  libpq-dev \
  && mkdir -p $APP_PATH

WORKDIR $APP_PATH

# copy entrypoint scripts and grant execution permissions
COPY ./bin/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

USER $APP_USER

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install --jobs 20 && bundle clean --force

COPY --chown=$APP_USER:$APP_USER . .

RUN $APP_PATH/bin/rails tmp:create

EXPOSE $RAILS_PORT

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "4000"]
