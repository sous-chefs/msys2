module Msys2
  module Mixin
    def should_override_execute?
      node['msys2']['override_execute']
    end

    def should_override_package?
      node['msys2']['override_package']
    end
  end
end
