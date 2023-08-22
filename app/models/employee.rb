class Employee < ApplicationRecord
  
  def full_name
    if first_name.empty? 
      last_name
    else
      "#{last_name}, #{first_name}"
    end
  end
end
