Facter.add(:nginx_version) do
  setcode do
    if Facter::Core::Execution.which('nginx')
      nginx_version = Facter::Core::Execution.execute('nginx -v 2>&1')
      %r{^nginx version: nginx\/([\w\.]+)}.match(nginx_version)[1]
    end
  end
end
