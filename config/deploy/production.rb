server '13.113.84.98', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/ubuntu/.ssh/id_rsa'
