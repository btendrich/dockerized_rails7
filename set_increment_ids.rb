#!/usr/bin/env ruby
require 'sequel'
require 'logger'
require 'pp'

$logger = Logger.new(STDERR)
$logger.info "Starting up..."

DB_URI = 'postgres://postgres:postgres@db/app_development'

$logger.debug "Connecting to database: #{DB_URI}"
DB = Sequel.connect(DB_URI)
$logger.info "Connected!"


DB << "ALTER SEQUENCE employees_id_seq RESTART WITH 10000"

$logger.info "Done!"
