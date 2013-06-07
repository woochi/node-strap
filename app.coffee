###
Module dependencies.
###

express = require("express")
routes = require("./routes")
users = require("./routes/users")
http = require("http")
path = require("path")
app = express()

# Load configuration
nconf = require("nconf")
nconf.file('./config.json')

# All environments
app.configure ->
  app.set "port", nconf.get("port")
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))
  app.use require('connect-assets')()
  css.root = '/stylesheets'
  js.root  = '/javascripts'

# Development only
app.configure "development", ->
  app.use express.errorHandler()

# Site routes
app.get "/", routes.index

# User routes
app.get "/users", users.list
app.post "/users", users.create
app.get "/users/:id", users.create
app.put "/users/:id", users.update
app.delete "/users/:id", users.delete

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
