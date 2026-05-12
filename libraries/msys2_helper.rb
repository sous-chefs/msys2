# frozen_string_literal: true

# Public: Collection of MSYS2 operations
module Msys2
  # Public: Helper methods for MSYS2 operations
  module Helper
    # Public: Determines if MSYS2 is installed on the system
    #
    # Returns Boolean
    def msys2_installed?(install_dir)
      ::Dir.exist?(install_dir)
    end
  end
end
