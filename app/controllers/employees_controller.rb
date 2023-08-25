class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy generate_paperwork generate_paperwork_form]

  # GET /employees or /employees.json
  def index
    #@employees = Employee.all
    if filter_status == 'active'
      @pagy, @employees = pagy(Employee.active.where("last_name ILIKE ? OR first_name ILIKE ?", search_name, search_name).order(sort_sql).order(:last_name).order(:first_name), items: 25)
    elsif filter_status == 'inactive'
      @pagy, @employees = pagy(Employee.inactive.where("last_name ILIKE ? OR first_name ILIKE ?", search_name, search_name).order(sort_sql).order(:last_name).order(:first_name), items: 25)
    else
      @pagy, @employees = pagy(Employee.where("last_name ILIKE ? OR first_name ILIKE ?", search_name, search_name).order(sort_sql).order(:last_name).order(:first_name), items: 25)
    end
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def generate_paperwork
    @errors = {}
    @defaults = {
      :rate => '62.06',
      :ot_rate => '93.09',
      :rate_uom => 'hour',
      :department_code => '50001-43-00-440-00-000000',
      :department => 'Performance and Campus Operations',
      :job_title => 'Concert Halls - Extra Stagehand Local One',
      :preparer => 'Jason Marsh',
      :preparer_title => 'Director, Event Production',
      :employer => 'LCPA',
      :employer_address => '70 Lincoln Center Plaza',
      :employer_city => 'New York',
      :employer_state => 'NY',
      :employer_zip => '10023',
      :union => 'Local One',
    }
    
    if request.method.upcase == 'POST'
      
      if not params.fetch(:generate).fetch(:ssn).empty?
        @errors[:ssn] = 'SSN format must be nnn-nn-nnnn' unless params.fetch(:generate).fetch(:ssn) =~ /^\d{3}-\d{2}-\d{4}$/
      end
      
      if @errors.empty?
        
        document = HexaPDF::Document.open Rails.root.join('input.pdf')
        
        canvas = document.pages[0].canvas(type: :overlay)
        canvas.font('Helvetica', size: 18 )
        canvas.fill_color('red')
        canvas.text("Prepared For: #{@employee.full_name}", at: [80,792-600])

        # payroll notice sheet
        canvas = document.pages[1].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('red')
        canvas.text(params[:generate][:department], at: [69,792-58])
        canvas.text(params[:generate][:date], at: [69,792-87])
        canvas.text(@employee.full_name, at: [67,792-181])
        canvas.text(params[:generate][:ssn], at: [59,792-202])
        canvas.text(@employee.dob.strftime('%Y-%m-%d'), at: [338,792-202]) if @employee.dob
        canvas.text(@employee.full_address, at: [118,792-221])
        canvas.text(@employee.phone, at: [95,792-241])
        canvas.text(params[:generate][:job_title], at: [95,792-293])
        canvas.text(params[:generate][:preparer], at: [101,792-311])
        canvas.text(params[:generate][:department], at: [365,792-311])
        canvas.text(params[:generate][:rate], at: [100,792-334])
        canvas.text(params[:generate][:rate_uom], at: [238,792-334])
        canvas.text(params[:generate][:department_code], at: [243,792-358])
        canvas.text('X', at: [247,792-401])
        canvas.text('X', at: [392,792-335])
        canvas.text('X', at: [158,792-480])
        canvas.text(params[:generate][:union], at: [191,792-480])
        canvas.text('X', at: [249.7,792-511.7])
        canvas.text('X', at: [530.5,792-511.7])
        canvas.text('See rate sheet for additional rates', at: [33,792-550])
        
        # rate notification sheet
        canvas = document.pages[2].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('red')
        canvas.text(params[:generate][:date], at: [80,792-175])
        canvas.text(@employee.full_name, at: [138,792-200])
        canvas.text(params[:generate][:date], at: [375,792-590])
        canvas.text(params[:generate][:department], at: [166,792-226])
        canvas.text(params[:generate][:rate], at: [168,792-298])
        canvas.text(params[:generate][:rate_uom], at: [247,792-298])
        canvas.text('X', at: [49,792-388])
        canvas.text(params[:generate][:ot_rate], at: [151,792-438])
        canvas.text(params[:generate][:preparer], at: [129,792-615])
        canvas.text(params[:generate][:preparer_title], at: [390,792-615])




        output_file = Tempfile.new
        document.write(output_file.path, optimize: true)

        send_file output_file.path, :disposition => 'inline', filename: "New Hire Paperwork - #{@employee.full_name}.pdf"
      else
        render :generate_paperwork_form, status: :unprocessable_entity
      end
    else
      render :generate_paperwork_form
    end

  end

  def generate_paperwork_form
    @errors = {}
    @defaults = {
      :rate => '62.06',
      :ot_rate => '93.09',
      :rate_uom => 'hour',
      :department_code => '50001-43-00-440-00-000000',
      :department => 'Performance and Campus Operations',
      :job_title => 'Concert Halls - Extra Stagehand Local One',
      :preparer => 'Jason Marsh',
      :preparer_title => 'Director, Event Production',
      :employer => 'LCPA',
      :employer_address => '70 Lincoln Center Plaza',
      :employer_city => 'New York',
      :employer_state => 'NY',
      :employer_zip => '10023',
      :union => 'Local One',
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :address1, :address2, :city, :state, :zip, :phone, :affiliation_organization, :affiliation_card_number, :payroll_code, :dob, :notes, :classification, :payroll_code, :payroll_active, :email, :keycard_number)
    end
    
    def search_name
        params[:search_name].nil? ? "%" : "%#{params[:search_name]}%"
    end
    
    def sort_field
      ['last_name', 'first_name'].include?(params[:sort_field]) ? params[:sort_field] : 'classification'
    end

    def filter_status
      params.fetch(:status,'active')
    end

end
