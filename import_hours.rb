#!/usr/bin/env ruby
require 'sequel'
require 'logger'
require 'pp'

$logger = Logger.new(STDERR)
$logger.info "Starting up..."

DB_URI = 'postgres://btendrich:bigbee@10.30.40.9/payroll'
DB2_URI = 'postgres://postgres:postgres@db/app_development'

$logger.debug "Connecting to database: #{DB_URI}"
DB = Sequel.connect(DB_URI)
$logger.info "Connected!"

$logger.debug "Connecting to database: #{DB2_URI}"
DB2 = Sequel.connect(DB2_URI)
$logger.info "Connected!"


count = 0
DB[:payrolls].each do |payroll|
  DB2[:payrolls].insert_conflict(target: :id, update: {name: Sequel[:excluded][:name], week_ending: Sequel[:excluded][:week_ending], submitted: Sequel[:excluded][:submitted], created_at: Sequel[:excluded][:created_at], updated_at: Sequel[:excluded][:updated_at]}).insert(
    id: payroll[:id],
    name: payroll[:name],
    week_ending: payroll[:week_ending],
    submitted: payroll[:submitted],
    created_at: payroll[:created_at],
    updated_at: payroll[:updated_at],
  )
  
  count = count + 1
end
$logger.info "Copied or updated #{count} payroll records"



count = 0
DB[:hours].each do |hour|
  old_rate = DB[:rates].where(id: hour[:rate_id]).first
  new_rate = DB2[:rates].where(short_code: old_rate[:short_code]).first
  time_period = DB2[:time_periods].where(Sequel.lit("begins <= ?", hour[:date])).where(Sequel.lit("ends >= ?", hour[:date])).first
  rate_amount = DB2[:rate_amounts].where(time_period_id: time_period[:id], rate_id: new_rate[:id]).first
  
  old_rate = {} unless old_rate
  new_rate = {} unless new_rate
  time_period = {} unless time_period
  rate_amount = {} unless rate_amount
  
  
  $logger.info "Working on hour id #{hour[:id]}"
  
  
  DB2[:payroll_items].insert_conflict(target: :id, update: {payroll_id: Sequel[:excluded][:payroll_id], source_hour_id: Sequel[:excluded][:source_hour_id], date: Sequel[:excluded][:date], employee_id: Sequel[:excluded][:employee_id], source_rate_id: Sequel[:excluded][:source_rate_id], 
    name: Sequel[:excluded][:name], short_code: Sequel[:excluded][:short_code], source_rate_amount_id: Sequel[:excluded][:source_rate_amount_id], amount: Sequel[:excluded][:amount], quantity: Sequel[:excluded][:quantity], total: Sequel[:excluded][:total], correction: Sequel[:excluded][:correction], 
    notes: Sequel[:excluded][:notes], created_at: Sequel[:excluded][:created_at], updated_at: Sequel[:excluded][:updated_at] }).insert( 
    id: hour[:id],
    payroll_id: hour[:payroll_id],
    source_hour_id: hour[:id],
    date: hour[:date],
    employee_id: hour[:employee_id],
    source_rate_id: new_rate.fetch(:id, nil),
    name: new_rate.fetch(:name, nil),
    short_code: new_rate.fetch(:short_code, nil),
    source_rate_amount_id: rate_amount.fetch(:id, nil),
    amount: rate_amount.fetch(:amount, nil),
    quantity: hour[:quantity],
    total: hour[:quantity]*rate_amount.fetch(:amount,0),
    correction: hour[:correction],
    notes: hour[:notes],
    created_at: hour[:created_at],
    updated_at: hour[:updated_at],    
  )
  
  DB2[:hours].insert_conflict(target: :id, update: {date: Sequel[:excluded][:date], employee_id: Sequel[:excluded][:employee_id], rate_id: Sequel[:excluded][:rate_id], quantity: Sequel[:excluded][:quantity], correction: Sequel[:excluded][:correction], notes: Sequel[:excluded][:notes], created_at: Sequel[:excluded][:created_at], updated_at: Sequel[:excluded][:updated_at]}).insert(
    id: hour[:id],
    date: hour[:date],
    employee_id: hour[:employee_id],
    rate_id: new_rate[:id],
    quantity: hour[:quantity],
    correction: hour[:correction],
    notes: hour[:notes],
    created_at: hour[:created_at],
    updated_at: hour[:updated_at],    
  )
  
  count = count + 1
end
$logger.info "Copied or updated #{count} hour records"




count = 0
DB[:hours].each do |hour|
  old_rate = DB[:rates].where(id: hour[:rate_id]).first
  new_rate = DB2[:rates].where(short_code: old_rate[:short_code]).first
  
  DB2[:hours].insert_conflict(target: :id, update: {date: Sequel[:excluded][:date], employee_id: Sequel[:excluded][:employee_id], rate_id: Sequel[:excluded][:rate_id], quantity: Sequel[:excluded][:quantity], correction: Sequel[:excluded][:correction], notes: Sequel[:excluded][:notes], created_at: Sequel[:excluded][:created_at], updated_at: Sequel[:excluded][:updated_at]}).insert(
    id: hour[:id],
    date: hour[:date],
    employee_id: hour[:employee_id],
    rate_id: new_rate[:id],
    quantity: hour[:quantity],
    correction: hour[:correction],
    notes: hour[:notes],
    created_at: hour[:created_at],
    updated_at: hour[:updated_at],    
  )
  
  count = count + 1
end
$logger.info "Copied or updated #{count} hour records"



