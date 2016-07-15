if defined?(ChefSpec)
  def msys2_installer(name)
    ChefSpec::Matchers::ResourceMatcher.new(:msys2_installer, :run, name)
  end

  def msys2_update(name)
    ChefSpec::Matchers::ResourceMatcher.new(:msys2_update, :run, name)
  end

  def msys2_execute(command)
    ChefSpec::Matchers::ResourceMatcher.new(:msys2_execute, :run, command)
  end

  def install_msys2_package(package)
    ChefSpec::Matchers::ResourceMatcher.new(:msys2_package, :install, package)
  end

  def remove_msys2_package(package)
    ChefSpec::Matchers::ResourceMatcher.new(:msys2_package, :remove, package)
  end
end
