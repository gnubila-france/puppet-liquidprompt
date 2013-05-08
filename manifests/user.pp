define liquidprompt::user(
  $user       = $title,
  $group      = $user,
  $repository = $liquidprompt::params::repository,
  $branch     = 'master',
  $update     = false,
  $home       = false,
  $shell      = 'bash',
  $battery    = undef
){

  require liquidprompt
  require liquidprompt::params

  # Validating parameters
  if $battery { validate_bool($battery) }
  if $home { validate_string($home) }
  validate_string($bash)

  $compatible_shells = ['bash','zsh']
  validate_re($shell, $compatible_shells)

  # Check for acpi if battery is selected.
  if $battery {
    if ! defined(Package['acpi']){
      package{'acpi': ensure => installed}
    }
  }

  $real_home = $home ? {
    false   => "/home/${user}",
    default => $home
  }

  $liquidprompt_dir = "${real_home}/.liquidprompt"
  $liquidprompt_config_dir = "${real_home}/.config"
  $liquidprompt_rc = "${liquidprompt_config_dir}/liquidpromptrc"
  $liquidprompt_file = "${liquidprompt_dir}/liquidprompt"

  if ! defined(File[$liquidprompt_config_dir]){
    file{$liquidprompt_config_dir:
      ensure  => directory,
      owner   => $user,
      group   => $group,
    }
  }

  git::repo{'install_liquidprompt':
    path    => $liquidprompt_dir,
    source  => $repository,
    branch  => $branch,
    update  => $update,
    owner   => $user,
    group   => $group,
  }

  file{"${liquidprompt_rc}":
    ensure  => file,
    content => template('liquidprompt/liquidpromptrc.erb'),
    owner   => $user,
    group   => $group,
  }

  file_line{'enable_liquiprompt':
    line => ". ${liquidprompt_file}",
    path => "${real_home}/.${shell}rc"
  }

}