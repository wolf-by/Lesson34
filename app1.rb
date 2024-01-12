#'product_1=1,product_2=2,product_3=3,'

orders_line = "product_1=1,product_2=2,product_3=3,"

def parse_orders_line orders_line

	s1 = orders_line.split(/,/)
	#puts s1.inspect

	arr = []

	s1.each do |x| 
		s2 = x.split(/=/)
		s3 = s2[0].split(/_/)
		#puts s3.inspect

		id = s3[1]
		cnt = s2[1]

		#puts "Product: #{key}, number of item: #{value}"
		arr2 = [id, cnt]
		arr.push arr2	

	end
	return arr
end	

puts parse_orders_line(orders_line).inspect