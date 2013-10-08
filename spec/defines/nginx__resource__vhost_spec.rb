require 'spec_helper'

describe 'nginx::resource::vhost' do

  describe 'applies allow and deny rules' do
    let (:title) { 'test' }
    let (:params) {{
      :www_root       => '/var/www/nginx',
      :location_allow => ['10.0.0.1', 'host1'],
      :location_deny  => ['host2', '10.0.0.2']
    }}

    it 'applies location_allow rules' do
      should contain_file('/nginx.d/test-500-test-default').with({
        'content' => /allow 10.0.0.1\n  allow host1/
      })
    end
    it 'applies location_deny rules' do
      should contain_file('/nginx.d/test-500-test-default').with({
        'content' => /deny host2\n  deny 10.0.0.2/
      })
    end
  end

end
