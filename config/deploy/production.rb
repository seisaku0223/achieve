server '52.197.128.79', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/ubuntu/.ssh/id_rsa'
