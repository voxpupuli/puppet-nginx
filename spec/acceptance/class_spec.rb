require 'spec_helper_acceptance'

describe "nginx class:" do
  case fact('osfamily')
  when 'RedHat'
    package_name = 'nginx'
  when 'Debian'
    package_name = 'nginx'
  when 'Suse'
    package_name = 'nginx-0.8'
  end

  context 'default parameters' do
    it 'should run successfully' do
      pp = "class { 'nginx': }"

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

  describe package(package_name) do
    it { is_expected.to be_installed }
  end

  describe service('nginx') do
    it { is_expected.to be_running }
  end

end
