# == Class: bashrc::install
#
class bashrc::install {
  if $::bashrc::package_name {
    package { 'bash':
      ensure => $::bashrc::package_ensure,
      name   => $::bashrc::package_name,
    }
  }

  if $::bashrc::package_list {
    ensure_resource('package', $::bashrc::package_list, { 'ensure' => $::bashrc::package_ensure })
  }
}
