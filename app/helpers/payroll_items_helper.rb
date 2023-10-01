module PayrollItemsHelper
  
  def payroll_list_helper
    output = Payroll.ordered_list.map{ |x| [x.full_name, x.id]}
    output.unshift ['All Payrolls', '']
    output
  end

end
