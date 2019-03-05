require 'spec_helper_acceptance'

describe 'nginx class:' do
  case fact('osfamily')
  when 'RedHat'
    pkg_cmd = 'yum info nginx | grep "^From repo"'
    pkg_remove_cmd = 'yum -y remove nginx nginx-filesystem passenger'
    pkg_match = %r{passenger}
  when 'Debian'
    pkg_cmd = 'dpkg -s nginx | grep ^Maintainer'
    pkg_remove_cmd = 'apt-get -y remove nginx nginx-common'
    pkg_match = case fact('operatingsystemmajrelease')
                when '9'
                  %r{Debian Nginx Maintainers}
                when '18.04'
                  %r{Ubuntu Developers}
                else
                  %r{Phusion}
                end
  end

  context 'default parameters' do
    it 'runs successfully' do
      pp = "class { 'nginx': }"
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe package('nginx') do
      it { is_expected.to be_installed }
    end

    describe service('nginx') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end

  context 'nginx with package_source passenger' do
    # TODO: also test for (expected) failure on 5
    unless fact('osfamily') == 'RedHat' && fact('operatingsystemmajrelease') == '5'
      it 'runs successfully' do
        shell(pkg_remove_cmd)
        pp = <<-EOS
          class { 'nginx':
            package_source => 'passenger'
          }
        EOS

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe package('nginx') do
        it { is_expected.to be_installed }
        it 'comes from the expected source' do
          pkg_output = shell(pkg_cmd)
          expect(pkg_output.stdout).to match pkg_match
        end
      end

      if fact('os.family') == 'Debian' && fact('os.release.major') == '8'
        describe package('nginx-extras') do
          it { is_expected.to be_installed }
        end
      end

      describe package('passenger') do
        it { is_expected.to be_installed }
      end

      describe service('nginx') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end

  context 'reset to default parameters' do
    it 'runs successfully' do
      shell(pkg_remove_cmd)
      pp = "class { 'nginx': }"
      apply_manifest(pp, catch_failures: true)
    end
  end
end
