class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    redirect_to :action => 'request_bill'
  end

  def request_bill
    @tenants = Tenant.all
  end
  # GET /reports/1
  # GET /reports/1.json
def generate_bills
  month_to_bill = params[:date][:bill_month]
  year_to_bill = params[:date][:bill_year]
  x=params[:tenant][:id]
#@invoicearray=[]
#@tenants = Tenant.all
@tenant2 = Tenant.find(x)
@testarray = []
@zones = @tenant2.zones.all
  @zones.each do | zn |
    puts zn.name
    if zn.bill_type="BO"
      puts 'Yippee'
      @to = TovList.new
      @to.zone=zn
      puts zn.event_id
      @to.build_list(zn.event_id, month_to_bill.to_i, year_to_bill.to_i)
      @testarray << @to

    end
  end

end

  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params[:report]
    end
end
