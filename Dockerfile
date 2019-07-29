# https://hub.docker.com/_/ruby
FROM ruby:2.5.1

# Only needed if running on kubernetes
RUN echo "if [ -e /confd/.env ]; then . /confd/.env; fi" >> /etc/profile
# Also kubernetes-only, PATH is reset for the ENV injection
RUN echo "export PATH=$PATH" >> ~/.bashrc

WORKDIR /app

# If you are using sidekiq-ent or other credential-requiring gems
# Uncomment the following two lines to persist the credential
# ARG BUNDLE_ENTERPRISE__CONTRIBSYS__COM
# ENV BUNDLE_ENTERPRISE__CONTRIBSYS__COM=$BUNDLE_ENTERPRISE__CONTRIBSYS__COM

COPY Gemfile* /app/

# COPY lib/deliveries_manager /app
COPY . /app
# Similar to --no-deployment, but we don't want to vendor the gems
RUN gem update --system
#RUN gem uninstall -i /usr/local/lib/ruby/gems/2.5.0 bundler

# RUN gem install bundler -v 2.0.2
ENV BUNDLER_VERSION 2.0.2
# RUN bundle --version
RUN gem install bundler
RUN bundle config --local frozen 1
RUN bundle install



CMD rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
#CMD bundle exec bin/rails s