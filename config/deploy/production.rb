server '13.113.150.21', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/takemura/.ssh/id_rsa'
