# == Class: bashrc::params
#
class bashrc::params {
  $package_name = $::osfamily ? {
    default => 'bash',
  }

  $package_list = $::osfamily ? {
    default => ['bash-completion'],
  }

  $selected_pager = 'LESS'
  $selected_editor = 'VIM'
  $selected_editor_path = '/usr/bin/vim.basic'
  
  $grep_color_value = 'ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

  $bashrcd_puppet_filename = 'puppet-custom.sh'

  $aliases = []
  $users = []
  $extensions = []
  
  $manage_custom_bashrc     = true
  $manage_etc_files         = true
  $manage_skeltons          = true

  $ps1_default              = '\u@\h:\w\$ '
  $ps1_colored              = '\[\033[38;5;1m\]\$?\[$(tput sgr0)\],\[\033[38;5;214m\]\t\[$(tput sgr0)\],\[\033[38;5;34m\]\u@\H\[$(tput sgr0)\]:\[\033[38;5;27m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] '
  $ps1_screen               = '\[\033[38;5;1m\]\$?\[$(tput sgr0)\],\[\033[38;5;214m\]\d \t [$(tput sgr0)\],\u@\H\[$(tput sgr0)\]:\[\033[38;5;27m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] '

  $template_etc_bashrc      = "${module_name}/etc/bashrc.erb"
  $template_etc_profile     = "${module_name}/etc/profile.erb"

  case $::osfamily {
    'Redhat': {
      $profileddirectory  = '/etc/profile.d'
      $bashrcdirectory    = '/etc/bashrc.d'
      $skeldirectory      = '/etc/skel/'
      $etcbashfile        = '/etc/bashrc'
      $maildirectory      = '/var/spool/mail'
    }

    'Debian': {
      $profileddirectory = '/etc/profile.d'
      $bashrcdirectory   = '/etc/bashrc.d'
      $skeldirectory     = '/etc/skel/'
      $etcbashfile       = '/etc/bash.bashrc'
      $maildirectory     = '/var/mail'
    }

    default: {
      $profileddirectory = '/etc/profile.d'
      $bashrcdirectory   = '/etc/bashrc.d'
      $skeldirectory     = '/etc/skel/'
      $etcbashfile       = '/etc/bashrc'
      $maildirectory     = '/var/mail'
    }
  }
}
