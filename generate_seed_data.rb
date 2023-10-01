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


###################### employee classifications ################
employee_classifications = {
  'Basic' => 1,
  'Extra' => 2,
  'Maintenance' => 3,
  'Retired' => 4,
}
employee_classifications.each do |name, id|
  lines << <<-EOF
EmployeeClassification.create(
  id: #{id},
  name: "#{name}",
)
EOF
end


###################### rate classifications ################
rate_classifications = {
  'Basic' => 1,
  'Extra' => 2,
  'Other' => 3,
}
rate_classifications.each do |name, id|
  lines << <<-EOF
RateClassification.create(
  id: #{id},
  name: "#{name}",
)
EOF
end

####################### rates ####################
rates = DB[:rates]
rates.each do |row|
  lines << <<-EOF
rate_classification = RateClassification.find_or_create_by(name: "#{row[:classification]}")
rate = Rate.find_or_create_by(short_code: "#{row[:short_code]}", rate_classification_id: rate_classification.id, name: "#{row[:classification]} #{row[:name]}")
RateAmount.create( 
  rate_id: rate.id,
  time_period_id: #{row[:time_period_id]},
  amount: #{row[:amount]}
)
EOF
end


#################### employees ##################
$logger.info "Starting generation of 'employees' seed data..."
rows=DB[:employees].order(:id)
$logger.debug "Found #{rows.count} records"
rows.each do |employee|
  classification_id = employee_classifications.fetch( employee[:classification], 0)
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
  employee_classification_id: #{classification_id},
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
