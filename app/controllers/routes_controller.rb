require 'pry'
require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'logging'

include Geokit::Geocoders
class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  
  def curl_get
    
     @options = []
    # @logger = Logger.new(File.join(home_dir,'download_validation.log'))
    @citys = ["Mumbai", "Pune", "PimpriChinchwad", "Nagpur", "Thane", "Nashik", "Aurangabad", "Solapur", "Kalyan", "Vasai", "NaviMumbai", "Thane", "Amravati", "Kolhapur", "Kolhapur", "MiraBhayandar", "Thane", "Akola", "BhiwandiNizampur", "Thane", "Dhule", "Jalgaon", "AreaJalgaon", "Nanded","Waghala", "Latur", "Panvel", "Raigad", "Ulhasnagar", "Thane", "Miraj", "Kupwad", "Sangli", "Malegaon", "Nashik", "Ahmednagar", "Ichalkaranji", "Kolhapur", "Chandrapur"]
      @cookie_index = 0
      @index = 3
    @output_dir = File.join(Dir.home,'msrtc')
    home_page_curl = "curl -v -L -o /tmp/99.html 'https://public.msrtcors.com/' -c #{out_cookie} -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Connection: keep-alive' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-GB,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' --compressed"
  res =  %x[#{home_page_curl}]
  
 guest_curl = "curl -v -L -o /tmp/2.html 'https://public.msrtcors.com/users/guest_user_wel.php' -b #{in_cookie} -c #{out_cookie} -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-GB,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: https://public.msrtcors.com/ticket_booking/index.php' -H 'Connection: keep-alive' --compressed"   
     res =  %x[#{guest_curl}]
     
    
 guest_curl_v2 = %Q[curl -v  -o #{write_index} 'https://public.msrtcors.com/users/guest_usr_form.php?status=' -L --silent --stderr /dev/null --max-redirs 10 --max-time 60 -b #{in_cookie} -c #{out_cookie}  -H 'Origin: https://public.msrtcors.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-GB,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://public.msrtcors.com/users/guest_usr_form.php?status=' -H 'Connection: keep-alive' --data 'email=user%40gmail.com&conemail=user%40gmail.com&mobno=7894561235&guest=1&button=Proceed' --compressed]
 
   
     
    res =  %x[#{guest_curl_v2}]
    
    @citys.each_with_index do |city|
      @citys.each {|city2| 
        next if city == city2
        puts "curl for #{city} and #{city2}"
      
    
    guest_v3 = %Q[curl -v  -o #{write_index} 'https://public.msrtcors.com/ticket_booking/bus.php'  -L --silent --stderr /dev/null --max-redirs 10 --max-time 60 -b #{in_cookie} -c #{out_cookie} -H 'Origin: https://public.msrtcors.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-GB,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://public.msrtcors.com/ticket_booking/frmrightframe.php?from_st=&to_st=&dept_tm=&is_return=&is_again=&quota=' -H 'Connection: keep-alive' --data 'error_msg=&bktype=gen&#{get_data(city,city2)}&jrdt=15-08-2017&cboservicetype=ALL&currentdate=31%2F07%2F17&search=Search&deptTm=00%3A00' --compressed]
    
   res3 =   %x[#{guest_v3}]
   
    page = Nokogiri::HTML(read)
    
    page.xpath("//tr[@class = 'even_TR lh']").each {|tr|
     info =  tr.xpath("//td[@class = 'label']") rescue break
   dept  =  info[1]
    sor = info[2]
    typ = info[3]
    
      @options << {
        :dept_time => dept,
        :source => sor,
        :bus_type => typ
        
      } 
   
    }
      }

    end
    
    
  end
  
  # GET /routes/1
  # GET /routes/1.json
  def show
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  def search
   

    respond_to do |format|
      # format.html { redirect_to @r, notice: 'Route was successfully created.' }
      format.json { render :find, status: :created, location: @routes }
      format.json render :partial => "routes/find"

    end
  end

  def find
    #@sources = Route.where(:source => params[:search], :destination => params[:destination]) if !params[:search].nil?  
                          
    if !params[:search].nil?
      @dist_cal = []
      @sources = []
      source  = MultiGeocoder.geocode('#{params[:search]}')
      dest  = MultiGeocoder.geocode('#{params[:destination]}')
        
      @dist_cal  <<  source.distance_to(dest, :units => :kms) rescue 0.0
      header = ["source","destination","date"]
sql = "SELECT routes.*, timmings.dept_time FROM routes JOIN timmings ON timmings.route_id = route_id WHERE source ='#{params[:search]}'"

      @sources = ActiveRecord::Base.connection.execute(sql).to_a
      @sourcess  =    @sources.select do |source_arr|
        index = -1  
       
       source_arr[2] = Time.parse(source_arr[2]).strftime('%A-%B-%d') rescue Time.now
       
        source_arr.map!{|source| source = "#{header[index+=1]}:#{source}"  }
      end
      

#       respond_to do |format|
#         format.html { redirect_to '/search' }
#    format.js  
#       end
    end
     
     #  format.json{}
     
   
  end

  def select_course
   
    @routes = Route.all
   

     

  end
  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_route
    @route = Route.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def route_params
    params.require(:route).permit(:source, :destination)
  end
end
