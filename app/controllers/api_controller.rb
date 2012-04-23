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
	          when "Categories"
	            categories
	          when "Category"
	            category
	          when "Category.Products"
	            category_products
	          when "Category.Pictures"
	            category_pictures
	          when "Products"
	            products
	          when "Product"
	            product
	          when "Product.Pictures"
	            product_pictures
	          when "Pictures"
	            pictures
	          when "Picture"
	            picture
	        end
	      else
	        return_response ApiReturn.new("004")
	      end
	    else
	      return_response ApiReturn.new("001")
	    end
	end

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
end
