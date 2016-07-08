class Chef
  class Resource
    class Msys2Package < Chef::Resource::Package
      resource_name :msys2_package
      provides :package, os: 'windows'
    end
  end
end
