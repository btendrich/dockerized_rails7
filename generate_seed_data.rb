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

employees=DB[:employees]

$logger.info "Starting generation of 'employees' seed data..."
$logger.debug "Found #{employees.count} records"


lines = []
employees.each do |employee|

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

File.write("db/seeds.rb", lines.join("\n"))


$logger.debug "Array is #{lines.count}"
pp lines.first

abort

hours = DB[:hours]

puts "Hours count is #{hours.count}"





## dates array starts empty
dates = []


## lets get all the dates covered by condition one and add them to the dates array
DB.fetch("SELECT * FROM hours_detail WHERE rate_short_code = 'B2' AND quantity = 6") do |row|
  
  ## so this date has somebody who got X hours of Y, lets see if the same person got A hours of B on the same day
  
  row2 = DB.fetch( "SELECT date FROM hours_detail WHERE date = ? AND employee_id = ? AND rate_short_code = 'B1' AND quantity IN (8,9)", row[:date], row[:employee_id])
  if row2.count > 0
    puts "Second hit on #{row[:date]}"
    row3 = DB.fetch( "SELECT date FROM hours_detail WHERE date = ? AND employee_id = ? AND rate_short_code = 'BP'", row[:date], row[:employee_id])
    if row3.count == 0
      puts "Third hit on #{row[:date]}"
      dates << row[:date]
    end
  end
end

puts "Date count is #{dates.count}"

dates.each do |date|
  puts date
end
## lets examin

#pp dates
