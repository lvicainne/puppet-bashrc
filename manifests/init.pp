# == Class: bashrc
#
#This class manages the bashrc additions.
#
#Please see the README.md
class bashrc(
  $package_ensure           = 'present',
  $package_name             = $bashrc::params::package_name,
  $package_list             = $bashrc::params::package_list,
  
  $bashrcdirectory          = $bashrc::params::bashrcdirectory,
  $etcbashfile              = $bashrc::params::etcbashfile,
  $skeldirectory            = $bashrc::params::skeldirectory,
  $maildirectory            = $bashrc::params::maildirectory,

  $selected_pager           = $bashrc::params::selected_pager,
  $selected_editor          = $bashrc::params::selected_editor,
  $selected_editor_path     = $bashrc::params::selected_editor_path,
  $grep_color_value         = $bashrc::params::grep_color_value,

  $bashrcd_puppet_filename  = $bashrc::params::bashrcd_puppet_filename,
  $aliases                  = $bashrc::params::aliases,
  $users                    = $bashrc::params::users,
  $extensions               = $bashrc::params::extensions,
  

  $manage_custom_bashrc     = $bashrc::params::manage_custom_bashrc,
  $manage_etc_files         = $bashrc::params::manage_etc_files,
  $manage_skeltons          = $bashrc::params::manage_skeltons,

  $ps1_default              = $bashrc::params::ps1_default,
  $ps1_colored              = $bashrc::params::ps1_colored,
  $ps1_screen               = $bashrc::params::ps1_screen,
  
  $template_etc_bashrc      = $bashrc::params::template_etc_bashrc,
  $template_etc_profile     = $bashrc::params::template_etc_profile,


  )inherits bashrc::params {
  validate_re($package_ensure, '^(absent|latest|present|purged)$')
  validate_string($package_name)
  
  validate_absolute_path($bashrcdirectory)
  validate_absolute_path($etcbashfile)
  validate_absolute_path($skeldirectory)
  validate_absolute_path($maildirectory)


  validate_string($selected_pager)
  validate_string($selected_editor)
  validate_absolute_path($selected_editor_path)
  validate_string($grep_color_value)
  
  validate_string($bashrcd_puppet_filename)
  validate_array($aliases)
  validate_array($users)
  validate_array($extensions)

  validate_bool($manage_custom_bashrc)
  validate_bool($manage_etc_files)
  validate_bool($manage_skeltons)

  validate_string($ps1_default)
  validate_string($ps1_colored)
  validate_string($ps1_screen)

  #validate_absolute_path($template_etc_bashrc)
  #validate_absolute_path($template_etc_profile)

  anchor { 'bashrc::begin': } ->
  class{'bashrc::install': } ->
  class{'bashrc::config': } ->
  anchor { 'bashrc::end': }

}
