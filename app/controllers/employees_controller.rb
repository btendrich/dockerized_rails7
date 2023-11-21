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

    if @employee.save
      redirect_to employee_url(@employee), notice: "Employee was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    if @employee.update(employee_params)
      redirect_to employee_url(@employee), notice: "Employee was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    redirect_to employees_url, notice: "Employee was successfully destroyed."
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
        canvas.fill_color('000f85')
        canvas.text("Prepared For: #{@employee.full_name}", at: [80,792-600])

        # payroll notice sheet
        canvas = document.pages[1].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(params[:generate][:department], at: [74,792-69])
        canvas.text(params[:generate][:date], at: [74,792-95])
        canvas.text(@employee.full_name, at: [77,792-189])
        canvas.text(params[:generate][:ssn], at: [66,792-209])
        canvas.text(@employee.dob.strftime('%Y-%m-%d'), at: [338,792-209]) if @employee.dob
        canvas.text(@employee.full_address, at: [114,792-228])
        canvas.text(@employee.phone, at: [92,792-248])
        canvas.text(params[:generate][:job_title], at: [94,792-296])
        canvas.text(params[:generate][:preparer], at: [102,792-314])
        canvas.text(params[:generate][:department], at: [365,792-314])
        canvas.text(params[:generate][:rate], at: [102,792-337])
        canvas.text(params[:generate][:rate_uom], at: [236,792-337])
        canvas.text(params[:generate][:department_code], at: [245,792-359])
        canvas.text('X', at: [247,792-401])
        canvas.text('X', at: [386,792-340])
        canvas.text('X', at: [160,792-477])
        canvas.text(params[:generate][:union], at: [196,792-475])
        canvas.text('X', at: [245,792-510])
        canvas.text('X', at: [518,792-510])
        canvas.text('See rate sheet for additional rates', at: [210,792-544])
        draw_bounding_box(canvas: canvas, start: 638, stop: 538)
        
        
        # rate notification sheet
        canvas = document.pages[2].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(params[:generate][:date], at: [87,792-188])
        canvas.text(@employee.full_name, at: [139,792-212])
        canvas.text(params[:generate][:department], at: [169,792-236])
        canvas.text(params[:generate][:rate], at: [176,792-304])
        canvas.text(params[:generate][:rate_uom], at: [251,792-304])
#        canvas.text('X', at: [49,792-388])
        canvas.text(params[:generate][:ot_rate], at: [159,792-438])
        canvas.text(params[:generate][:date], at: [376,792-585])
#        canvas.text(params[:generate][:preparer], at: [129,792-615])
#        canvas.text(params[:generate][:preparer_title], at: [390,792-615])
        draw_bounding_box(canvas: canvas, start: 617, stop: 201)
        signature_line(canvas: canvas, x: 155, y: 215 , length: 173)

        # w-4
        canvas = document.pages[4].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.first_name, at: [108,792-117])
        canvas.text(@employee.last_name, at: [280,792-117])
        canvas.text(params[:generate][:ssn], at: [472,792-117])
        canvas.text(@employee.address, at: [108,792-139])
        canvas.text(@employee.city_state_zip, at: [108,792-162])
        canvas.text(params[:generate][:date], at: [461,792-618])
        draw_bounding_box(canvas: canvas, start: 695, stop: 153)
        signature_line(canvas: canvas, x: 108, y: 180 , length: 330)
        
        
        # IT-2104
        canvas = document.pages[5].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.first_name, at: [50,792-117])
        canvas.text(@employee.last_name, at: [256,792-117])
        canvas.text(params[:generate][:ssn], at: [430,792-117])
        canvas.text(@employee.address, at: [50,792-140])
        canvas.text(@employee.city_state_zip, at: [50,792-163])
        canvas.text(params[:generate][:date], at: [460,792-347])
        draw_bounding_box(canvas: canvas, start: 697, stop: 441)
        signature_line(canvas: canvas, x: 49, y: 449 , length: 358)

        # I-9
        canvas = document.pages[6].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.first_name, at: [49,792-193])
        canvas.text(@employee.last_name, at: [256,792-193])
        canvas.text(@employee.address, at: [49,792-218])
        canvas.text(@employee.city, at: [302,792-218])
        canvas.text(@employee.state, at: [452,792-218])
        canvas.text(@employee.zip, at: [498,792-218])
        canvas.text(@employee.dob.strftime('%Y-%m-%d'), at: [49,792-243])
        canvas.text(params[:generate][:ssn], at: [157,792-243])
        canvas.text(@employee.phone, at: [447,792-243])
        canvas.text(params[:generate][:date], at: [370,792-371])
        draw_bounding_box(canvas: canvas, start: 620, stop: 418)
        signature_line(canvas: canvas, x: 123, y: 430 , length: 236)

        # I-9 page 2
        canvas = document.pages[7].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.last_name, at: [50,792-140])
        canvas.text(@employee.first_name, at: [261,792-140])

        # check off
        canvas = document.pages[8].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.full_name, at: [102,792-495])
        canvas.text(@employee.address, at: [88,792-518])
        canvas.text(@employee.city, at: [73,792-540])
        canvas.text(params[:generate][:ssn], at: [330,792-540])
        canvas.text(@employee.state, at: [74,792-562])
        canvas.text(@employee.zip, at: [224,792-562])
        canvas.text(params[:generate][:date], at: [330,792-562])
        draw_bounding_box(canvas: canvas, start: 462, stop: 225)
        signature_line(canvas: canvas, x: 350, y: 283 , length: 208)

        # paid family leave
        canvas = document.pages[9].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.full_name, at: [43,792-249])
        canvas.text(@employee.address, at: [43,792-275])
        canvas.text(@employee.city_state_zip, at: [43,792-298])
        canvas.text(@employee.phone, at: [461,792-298])
        canvas.text(params[:generate][:date], at: [483,792-608])
        draw_bounding_box(canvas: canvas, start: 563, stop: 164)
        signature_line(canvas: canvas, x: 127, y: 189 , length: 284)

        # harassment acknowledgement
        canvas = document.pages[10].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.full_name, at: [96,792-293])
        canvas.text(params[:generate][:date], at: [304,792-257])
        draw_bounding_box(canvas: canvas, start: 555, stop: 483)
        signature_line(canvas: canvas, x: 96, y: 541 , length: 141)

        # employment survey
        canvas = document.pages[11].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.first_name, at: [118,792-313])
        canvas.text(@employee.last_name, at: [294,792-313])
        canvas.text(params[:generate][:date], at: [474,792-313])
        draw_bounding_box(canvas: canvas, start: 490, stop: 47)
        signature_line(canvas: canvas, x: 109, y: 410 , length: 190)

        # required notices
        canvas = document.pages[12].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.full_name, at: [200,792-346])
        canvas.text(params[:generate][:date], at: [365,792-425])
        canvas.text(params[:generate][:date], at: [365,792-515])
        draw_bounding_box(canvas: canvas, start: 462, stop: 225)
        signature_line(canvas: canvas, x: 119, y: 376 , length: 210)
        signature_line(canvas: canvas, x: 119, y: 281 , length: 210)

        # emergency contact
        canvas = document.pages[13].canvas(type: :overlay)
        canvas.font('Helvetica', size: 12 )
        canvas.fill_color('000f85')
        canvas.text(@employee.full_name, at: [228,792-188])
        canvas.text(@employee.address, at: [228,792-315])
        canvas.text(@employee.city_state_zip, at: [228,792-339])
        canvas.text(@employee.phone, at: [228,792-388])
        canvas.text(@employee.email, at: [228,792-413])
        canvas.text(params[:generate][:date], at: [228,792-667])
        draw_bounding_box(canvas: canvas, start: 614, stop: 117)


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
      :rate => '63.61',
      :ot_rate => '95.42',
      :rate_uom => 'hour',
      :department_code => '50001-43-440-00-000000 (Alice Tully Hall)',
      :department => 'Performance and Campus Operations',
      :job_title => 'Concert Halls - Extra Stagehand Local One',
      :preparer => 'Brianna Poh-Beck',
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
    
    def draw_bounding_box(canvas: , start: 0, stop: 0)
      canvas.stroke_color('red')
      canvas.line_width = 5
      canvas.line(22.5, start+2.5, 45, start+2.5)
      canvas.line(25, start, 25, stop)
      canvas.line(22.5, stop-2.5, 45, stop-2.5)
      canvas.stroke
    end
    
    def signature_line(canvas: , x:, y:, length: 50, line_width: 15)
      canvas.stroke_color('ffff9c')
      canvas.line_width = line_width
      canvas.line(x, y, x+length, y)
      canvas.stroke
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :address1, :address2, :city, :state, :zip, :phone, :affiliation_organization, :affiliation_card_number, :payroll_code, :dob, :notes, :employee_classification_id, :payroll_code, :payroll_active, :email, :keycard_number, :status)
    end
    
    def search_name
        params[:search_name].nil? ? "%" : "%#{params[:search_name]}%"
    end
    
    def sort_field
      ['last_name', 'first_name'].include?(params[:sort_field]) ? params[:sort_field] : 'employee_classification_id'
    end

    def filter_status
      params.permit(:status).fetch(:status,'active')
    end

end
