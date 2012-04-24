class ApiController < ApplicationController
	
	def test
		return_response ApiReturn.new("000")
	end

	def call
		# check params check sum
	    if verify_checksum
	      # check params exists system require params
	      if verify_sys_params
	        case params[:M]
	        	# channel and activity
	          	when "Channels.Get"
	            	channels
	          	when "Channel.Follow"
	            	channel_follow
	          	when "Channel.UnFollow"
	            	channel_unfollow
	           	when "Activities.Get"
	           		activities
	            when "Activity.Follow"
	            	activity_follow
	            when "Activity.UnFollow"
	            	activity_unfollow
	        end
	      else
	        return_response ApiReturn.new("004")
	      end
	    else
	      return_response ApiReturn.new("001")
	    end
	end

	private
	
	def verify_checksum
    	hash = params[:H]
    	md5_string = params.sort.collect do |s|
      		unless s[0] == "action" || s[0] == "H" || s[0] == "controller"
        		s[0] + "=" + s[1] 
      		end
    	end
    	Digest::MD5.hexdigest(md5_string.compact.join("&")) == hash
  	end

  	def verify_sys_params
    	if params[:M] && params[:H] && params[:D] && params[:V]
      		true
    	else
      		false
    	end
  	end

  	def return_response(api_return)
	    respond_to do |format|
	      	format.html { render json: api_return }
	      	format.json { render json: api_return }
	    end
  	end
  
  	# get all channels
	def channels
	    categories = Channels.all
	    re = ApiReturn.new("000")
	    re.data = categories
	    return_response(re)
	end

	def channel_follow
	end
end
