ENV['SINATRA_ENV'] ||= "development"

# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "postgresql",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

# require_all 'app'

# configure :production do
#    db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

#    ActiveRecord::Base.establish_connection(
#      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#      :host     => db.host,
#      :username => db.user,
#      :password => db.password,
#      :database => db.path[1..-1],
#      :encoding => 'utf8'
#      )

#      require_all 'app'
# end


require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

ActiveRecord::Base.establish_connection(
  :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :database => db.path[1..-1]
)

require_all 'app'