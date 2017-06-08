configure :test do
   set :database, {
     adapter: 'postgresql',
     encoding: 'utf8',
     database: 'onebitbot_test',
     pool: 5,
     username: 'postgres',
     host: 'postgres'
   }
end

configure :development do
 set :database, {
   adapter: 'postgresql',
   encoding: 'utf8',
   database: 'onebitbot_development',
   pool: 5,
   username: 'postgres',
   host: 'postgres'
 }
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/onebitbot_production')

  set :database, {
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    encoding: 'utf8',
    database: db.path[1..-1],
    username: db.user,
    password: db.password,
    host:     db.host
  }

end
