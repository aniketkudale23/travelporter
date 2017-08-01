require 'pry'
require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'logging'
require File.expand_path('../../config/environment', __FILE__)

def main 
  @options = []
  begin 
    
 
  

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
   
    index_c = 0
    @citys.each_with_index do |city,index|
      index_c += 1
      next unless index >= index
      
      @citys.each {|city2| 
        next if city == city2
        puts "curl for #{city} and #{city2}"
      
    
        guest_v3 = %Q[curl -v  -o #{write_index} 'https://public.msrtcors.com/ticket_booking/bus.php'  -L --silent --stderr /dev/null --max-redirs 10 --max-time 60 -b #{in_cookie} -c #{out_cookie} -H 'Origin: https://public.msrtcors.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-GB,en-US;q=0.8,en;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://public.msrtcors.com/ticket_booking/frmrightframe.php?from_st=&to_st=&dept_tm=&is_return=&is_again=&quota=' -H 'Connection: keep-alive' --data 'error_msg=&bktype=gen&#{get_data(city,city2)}&jrdt=15-08-2017&cboservicetype=ALL&currentdate=01%2F08%2F17&search=Search&deptTm=00%3A00' --compressed]
    
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
        puts @options.length
      }

    end
    
    binding.pry
  
  rescue Exception => e
    
   
    
    @options.each do |option|
      
      dept_time = option[:dept_time].text
      source = option[:source].text.split("to")[0]
      destination = option[:source].text.split("to")[1]
      bus_type = option[:bus_type].text
      
    route_check = Route.where(:source => source, :destination => destination)
      if route_check.empty?
        route  = Route.new(:source => source, :destination => destination)
        route.save
        timming = Timming.new(:dept_time => dept_time, :bus_type => bus_type, :provider_id => 8 )
        timming.route_id = route.id
        timming.save
     
      else
        timming = Timming.new(:dept_time => dept_time, :bus_type => bus_type, :provider_id => 8 )
        timming.route_id = route_check.ids.first
        timming.save
      
      end
    end
    binding.pry
    
  end
    
end

def in_cookie
  "#{@output_dir}/cookie_#{@cookie_index}"
end
  
def read
  
  File.read("/tmp/#{@index}.html")
end
  
def write_index
  @index += 1
  "/tmp/#{@index}.html"
end

def out_cookie   
  @cookie_index += 1   
  #   if @cookie_index < 4
  "#{@output_dir}/cookie_#{@cookie_index}"
end
  
def get_data(source,dest)
  #CGI::escape("fromstop=#{source.upcase}(#{source.upcase})&tostop=#{dest.upcase}(#{dest.upcase})")
  "fromstop=#{source.upcase}%28#{source.upcase}%29&tostop=#{dest.upcase}%28#{dest.upcase}%29"
end

main