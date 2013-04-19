class eventstore::package {
  $dir = $eventstore::dir
  $version = $eventstore::version
  $url = $eventstore::url
  $ensure = $eventstore::ensure
  
  if $ensure = 'present' {
    wget::fetch { 'download_eventstore':
      source      => "$url",
      destination => "/usr/local/src/eventstore-$version.tar.gz",
      before      => Exec['untar_eventstore'],
    }
    exec { 'untar_eventstore':
      command => "tar xvfj /usr/local/src/eventstore-$version.tar.gz",
      cwd     => '/opt',
      creates => "${dir}-$version",
      path    => ['/bin', '/usr/bin'],
      before  => File[dir],
    }
    file { $dir:
      ensure => link,
      target => "${$dir}-$version",
    }
  } else{
    file {"/usr/local/src/eventstore-$version.tar.gz":
      ensure => absent,
    }
    file { "/usr/local/src/eventstore-$version.tar.gz":
      ensure => absent,
    }
    file { $dir:
      ensure => absent,
    }
  }
  
}