# Rack Dispatcher

# Require your environment file to bootstrap Rails
require File.dirname(__FILE__) + '/config/environment'

use Rack::ShowStatus
use Rack::ShowExceptions
use Rails::Rack::Static

# Dispatch the request
run ActionController::Dispatcher.new

