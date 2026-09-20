# frozen_string_literal: true

Facter.add(:nginx_version) do
  confine { Facter.value(:kernel) != 'windows' }
  confine { Facter.value(:os)['name'] != 'nexus' }
  setcode do
    if Facter::Core::Execution.which('nginx') || Facter::Core::Execution.which('openresty')
      nginx_version_command = Facter::Core::Execution.which('nginx') ? 'nginx -v 2>&1' : 'openresty -v 2>&1'
      nginx_version = Facter::Core::Execution.execute(nginx_version_command)
      %r{nginx version: (nginx|openresty)/([\w.]+)}.match(nginx_version)[2]
    end
  end
end
