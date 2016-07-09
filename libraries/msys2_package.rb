require 'chef/provider/package'
require 'chef/resource/package'
require 'chef/mixin/command'

class Chef
  class Provider
    class Package
      class Msys2Package < Chef::Provider::Package::Pacman
        include ::Msys2::Mixin
        prepend ::Msys2MonkeyPatch

        def override_package?
          should_override_package?
        end

        provides :package, os: 'windows', override: override_package?
        provides :msys2_package, os: 'windows'

      end
    end
  end
end
