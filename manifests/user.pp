define liquidprompt::user(
  $user       = $title,
  $group      = $user,
  $repository = $liquidprompt::params::repository,
  $branch     = 'master',
  $update     = false,
  $home       = false,
  $shell      = 'bash',
  $battery    = undef
) inherits liquidprompt::params {

  # Validating parameters
  if $battery { validate_bool($battery) }
  if $home { validate_string($home) }
  validate_string($bash)

  $compatible_shells = ['bash','zsh']
  if ! validate_re($shell, $compatible_shells){
    fail("LiquidPrompt is not compatible with ${shell}, only bash and zsh are supported.")
  }

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
  $liquidprompt_rc = "${real_home}/.config/liquidpromptrc"
  $liquidprompt_file = "${liquidprompt_dir}/liquidprompt"

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