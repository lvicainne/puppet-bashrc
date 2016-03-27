# == Class: bashrc::config
#
class bashrc::config inherits bashrc {

    if($bashrc::manage_skeltons) {
      #SKELTON directory
      file { $bashrc::skeldirectory:
        ensure   => 'directory',
        owner    => 'root',
        group    => 'root',
        mode     => '0755',
        purge    => true,
      }

      file { "${bashrc::skeldirectory}/.bash_logout":
        ensure   => 'file',
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        content => template("${module_name}/skel/bash_logout.erb"),
      }

      file { "${bashrc::skeldirectory}/.bashrc":
        ensure   => 'file',
        owner    => 'root',
        group    => 'root',
        mode     => '0644',
        content => template("${module_name}/skel/bashrc_${::osfamily}.erb"),
      }


      case $::osfamily {
        'RedHat': {
            file { "${bashrc::skeldirectory}/.bash_login":
                ensure => 'absent',
            }

            file { "${bashrc::skeldirectory}/.bash_profile":
              ensure   => 'file',
              owner    => 'root',
              group    => 'root',
              mode     => '0644',
              content => template("${module_name}/skel/profile.erb"),
            }

            file { "${bashrc::skeldirectory}/.profile":
              ensure   => 'absent',
            }
        }
        default: {
            file { "${bashrc::skeldirectory}/.bash_login":
                ensure => 'absent',
            }

            file { "${bashrc::skeldirectory}/.bash_profile":
              ensure   => 'absent',
            }

            file { "${bashrc::skeldirectory}/.profile":
              ensure   => 'file',
              owner    => 'root',
              group    => 'root',
              mode     => '0644',
              content => template("${module_name}/skel/profile.erb"),
            }
        }
      }

    }

  if($bashrc::manage_etc_files) {
    #/etc/ directory
    file { $bashrc::etcbashfile:
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      content => template($bashrc::template_etc_bashrc),
    }

    file { '/etc/profile':
      ensure   => 'file',
      owner    => 'root',
      group    => 'root',
      mode     => '0644',
      content => template($bashrc::template_etc_profile),
    }
  }
  
  #PROFILE.D directory
  file { '/etc/profile.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  
  file { '/etc/bashrc.d':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if($bashrc::manage_custom_bashrc) {

      $profiled_path = "/etc/bashrc.d/${bashrc::bashrcd_puppet_filename}"

      concat { $profiled_path:
        ensure => 'present',
        owner  => 'root',
        group  => 'root',
        mode   => '644'
      }

      concat::fragment { '/etc/bashrc.d/colors':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-0-colors.sh"),
        order   => '01'
      }

      concat::fragment { '/etc/bashrc.d/basicaliases':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-basicaliases.sh"),
      }

      concat::fragment { '/etc/bashrc.d/coloraliases':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-coloraliases.sh"),
      }

      concat::fragment { '/etc/bashrc.d/softwares':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-softwares.sh"),
      }

      concat::fragment { '/etc/bashrc.d/ps1':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-ps1.sh"),
      }

      concat::fragment { '/etc/bashrc.d/extensions':
        target  => $profiled_path,
        content => template("${module_name}/etc/bashrc.d/custompuppet-extensions.sh"),
      }
  }

  $bashrc::users.each |Hash $key| {
        $userdirectory = $key['homedirectory']
        $current_user = $key['username']
        $managelocalbashrc = $key['managelocalbashrc']

        case $::osfamily {
            'RedHat': {
                file { "${userdirectory}/.bash_login":
                    ensure => 'absent',
                }

                file { "${userdirectory}/.bash_profile":
                    ensure  => 'file',
                    owner   => $current_user,
                    group   => $current_user,
                    mode    => '0644',
                    content => template("${module_name}/skel/profile.erb"),
                }

                file { "${userdirectory}/.profile":
                    ensure   => 'absent',
                }
            }
            default: {
                file { "${userdirectory}/.bash_login":
                    ensure => 'absent',
                }

                file { "${userdirectory}/.bash_profile":
                    ensure   => 'absent',
                }

                file { "${userdirectory}/.profile":
                    ensure  => 'file',
                    owner   => $current_user,
                    group   => $current_user,
                    mode    => '0644',
                    content => template("${module_name}/skel/profile.erb"),
                }
            }
        }

        #Selected Editor
        if($bashrc::selected_editor_path) {
            file { "${userdirectory}/.selected_editor":
                ensure  => 'file',
                content => template("${module_name}/user/selected_editor.erb"),
            }
        } else {
            file { "${userdirectory}/.selected_editor":
                ensure => 'absent',
            }
        }

        #Local BashRC
        if($managelocalbashrc) {
            file { "${userdirectory}/.bashrc":
              ensure   => 'file',
              owner    => $current_user,
              group    => $current_user,
              mode     => '0644',
              content => template("${module_name}/skel/bashrc_${::osfamily}.erb"),
            }
        }
    }

}
