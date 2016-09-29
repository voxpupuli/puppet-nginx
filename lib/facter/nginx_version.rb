Facter.add(:nginx_version) do
  setcode do
    if Facter.value('kernel') != 'windows' && (Facter::Util::Resolution.which('nginx') || Facter::Util::Resolution.which('openresty'))
      nginx_version_command = Facter::Util::Resolution.which('nginx') ? 'nginx -v 2>&1' : 'openresty -v 2>&1'
      nginx_version = Facter::Util::Resolution.exec(nginx_version_command)
      %r{nginx version: (nginx|openresty)\/([\w\.]+)}.match(nginx_version)[2]
    end
  end
end
