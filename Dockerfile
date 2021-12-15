# MANAGED BY MODULESYNC
# https://voxpupuli.org/docs/updating-files-managed-with-modulesync/

FROM ruby:2.7

WORKDIR /opt/puppet

# https://github.com/puppetlabs/puppet/blob/06ad255754a38f22fb3a22c7c4f1e2ce453d01cb/lib/puppet/provider/service/runit.rb#L39
RUN mkdir -p /etc/sv

ARG PUPPET_GEM_VERSION="~> 6.0"
ARG PARALLEL_TEST_PROCESSORS=4

# Cache gems
COPY Gemfile .
RUN bundle install --without system_tests development release --path=${BUNDLE_PATH:-vendor/bundle}

COPY . .

RUN bundle install
RUN bundle exec rake release_checks

# Container should not saved
RUN exit 1
