# https://hub.docker.com/_/ruby
FROM ruby:2.5.1


# Install the software you need
RUN apt-get update -qq \
&& apt-get install -y \
apt-utils \
build-essential \
libpq-dev \
libjpeg-dev \
libpng-dev \
nodejs

RUN mkdir /app

WORKDIR /app

# If you are using sidekiq-ent or other credential-requiring gems
# Uncomment the following two lines to persist the credential
# ARG BUNDLE_ENTERPRISE__CONTRIBSYS__COM
# ENV BUNDLE_ENTERPRISE__CONTRIBSYS__COM=$BUNDLE_ENTERPRISE__CONTRIBSYS__COM

COPY Gemfile* /app/
COPY ./lib/deliveries_manager/ /app/lib/deliveries_manager/

# Similar to --no-deployment, but we don't want to vendor the gems
RUN gem update --system
#RUN gem uninstall -i /usr/local/lib/ruby/gems/2.5.0 bundler

# RUN gem install bundler -v 2.0.2
ENV BUNDLER_VERSION 2.0.2
RUN gem install bundler
RUN bundle install  

# COPY lib/deliveries_manager /app
COPY . /app



# CMD rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
# CMD bundle exec bin/rails s

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80
EXPOSE 3000
EXPOSE 1234
EXPOSE 26162
# Start the main process.
CMD ["bin/rails", "server", "-b", "0.0.0.0"]