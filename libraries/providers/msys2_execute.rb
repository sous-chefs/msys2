class Chef
  class Provider
    class Msys2Execute < Chef::Provider::Execute
      include Msys2::Helper

      provides :execute, os: 'windows', override: true
      provides :msys2_execute, os: 'windows'

      def action_run
        shell_out!(generate_msys_command(command))
      end
    end
  end
end
