class Chef
  class Resource
    class Msys2Execute < Chef::Resource::Execute
        resource_name :msys2_execute
        provides :execute, os: 'windows'
    end
  end
end
