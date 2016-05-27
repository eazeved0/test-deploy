file { "/etc/icinga/objects/remote_icinga.cfg":
        ensure => "present",
        owner => "root",
        group => "root",
        mode => "664",
        content => "
define host{
        use                     generic-host
        host_name               remote
        alias                   remote
        address         10.0.0.52
        }

define service {
        use                     generic-service
        host_name               remote
        service_description     HTTP
        check_command           check_http
}

define service {
        use                     generic-service
        host_name               remote
        service_description     MYSQL
        check_command           check_tcp!3900
}

",
}

