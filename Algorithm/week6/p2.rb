arr = Array.new
ret = 0
progress = 0

File.open(ARGV[0]).each do |xx|
	x = xx.to_i
	if arr.size==0 || x<arr[0] then
		arr.insert 0, x
	elsif x>arr[arr.size-1] then
		arr<<x
	else
		(1..arr.size-1).each do |idx|
			if arr[idx-1]<=x && x<=arr[idx] then
				arr.insert idx, x
				break
			end
		end
	end

	mid = (arr.size+1)/2 - 1
	ret = (ret + arr[mid])%10000

	progress+=1
	puts "10000/#{progress}"
	#puts " +#{x}"
	#puts "M=#{arr[mid]} A=#{arr}"
end

puts ret