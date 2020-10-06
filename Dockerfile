FROM ruby:2.7.2-alpine
RUN apk add git
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app
COPY . .
COPY Gemfile Gemfile.lock ./
RUN bundle install

#

CMD ["ruby -v"]

#You can then build and run the Ruby image:
#
#$ docker build -t my-ruby-app .
#$ docker run -it --name my-running-script my-ruby-app
#
#Generate a Gemfile.lock
#
#The above example Dockerfile expects a Gemfile.lock in your app directory. This docker run will help you generate one. Run it in the root of your app, next to the Gemfile:
#
#$ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.7.2 bundle install
#
#Run a single Ruby script
#
#For many simple, single file projects, you may find it inconvenient to write a complete Dockerfile. In such cases, you can run a Ruby script by using the Ruby Docker image directly:
#
#$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp ruby:2.5 ruby your-daemon-or-script.rb
#
#Encoding
#
#By default, Ruby inherits the locale of the environment in which it is run. For most users running Ruby on their desktop systems, that means it's likely using some variation of *.UTF-8 (en_US.UTF-8, etc). In Docker however, the default locale is C, which can have unexpected results. If your application needs to interact with UTF-8, it is recommended that you explicitly adjust the locale of your image/container via -e LANG=C.UTF-8 or ENV LANG C.UTF-8.