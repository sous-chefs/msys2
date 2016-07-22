# Public: Collection of MSYS2 operations
module Msys2
  # Public: Helper methods for MSYS2 operations
  module Helper
    # Public: Determines if MSYS2 is installed on the system
    #
    # Returns Boolean
    def msys2_installed?
      ::Dir.exist?(node['msys2']['install_dir'])
    end

    # Public: Determines if MSYS2 should update when the msys2::default recipe
    # is run
    #
    # Returns Boolean
    def should_update?
      node['msys2']['auto_update']
    end
  end
end
