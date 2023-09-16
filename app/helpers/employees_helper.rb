module EmployeesHelper
  
  def employee_payroll_active_color_code(employee)
    employee.payroll_active? ? "bg-green-100" : "bg-red-100"
  end
  
  def employee_classification_color_code(employee)
    case employee.employee_classification.name
    when 'Basic'
      'bg-green-100'
    when 'Extra'
      'bg-indigo-100'
    when 'Maintenance'
      'bg-emerald-100'
    when 'Retired'
      'bg-yellow-100'
    else
      'bg-gray-100'
    end
  end
end
