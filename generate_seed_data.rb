#!/usr/bin/env ruby
require 'sequel'
require 'logger'
require 'pp'

$logger = Logger.new(STDERR)
$logger.info "Starting up..."

DB_URI = 'postgres://btendrich:bigbee@10.30.40.9/payroll'

$logger.debug "Connecting to database: #{DB_URI}"
DB = Sequel.connect(DB_URI)
$logger.info "Connected!"


lines = []


#################### employees ##################
$logger.info "Starting generation of 'employees' seed data..."
rows=DB[:employees].order(:id)
$logger.debug "Found #{rows.count} records"
rows.each do |employee|
  lines << <<-EOF
Employee.create(
  id: #{employee[:id]},
  last_name: "#{employee[:last_name]}",
  first_name: "#{employee[:first_name]}",
  address1: "#{employee[:address]}",
  address2: "#{employee[:apartment]}",
  city: "#{employee[:city]}",
  state: "#{employee[:state]}",
  zip: "#{employee[:zip]}",
  phone: "#{employee[:phone]}",
  affiliation_organization: "#{employee[:affiliation]}",
  affiliation_card_number: "",
  keycard_number: "#{employee[:card_number]}",
  dob: "",
  notes: "#{employee[:notes]}",
  classification: "#{employee[:classification]}",
  payroll_code: "#{employee[:payroll_file_number]}",
  payroll_active: "#{employee[:active]}"
)
EOF
end

#################### time_periods ##################
$logger.info "Starting generation of 'time_periods' seed data..."
rows=DB[:time_periods].order(:id)
$logger.debug "Found #{rows.count} records"
rows.each do |time_period|
  lines << <<-EOF
TimePeriod.create(
  id: #{time_period[:id]},
  name: '#{time_period[:name]}',
  begins: '#{time_period[:begins]}',
  ends: '#{time_period[:ends]}',
  description: '#{time_period[:description]}',
)
EOF
end



$logger.debug "Writing #{lines.count} records..."
File.write("db/seeds.rb", lines.join("\n"))

$logger.info "Wrote out to db/seeds.rb"
