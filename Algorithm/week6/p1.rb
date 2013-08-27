ints = Hash.new false
sum = Hash.new false
num = 0

=begin
idx = 0
File.open(ARGV[0]).each do |yy|
	y = yy.to_i
	if ints[y] then 
		if -10000<=y+y && y+y<=10000 then 
			sum[y+y] = true
		end
	else
		ints.each_key do |x|
			if -10000<=x+y && x+y<=10000 then 
				sum[x+y] = true
			end
		end
		ints[y] = true
	end
	puts "idx=#{idx}"
	idx += 1
end
=end

File.open(ARGV[0]).each do |x|
	ints[x.to_i] = true
end

=begin 
for idx in -10000..10000 do 
	ints.keys.each do |x| 
		y = idx - x 
		if y!=x && ints[y] then 
			num += 1
			break
		end
	end
	puts "#{idx} : #{num}"
end
=end

idx = 0
totalints = ints.size
ints.keys.each do |x|
	for t in -10000..10000 do 
		if sum[t] then next end

		y = t - x 
		if y!=x && ints[y] then
			sum[t] = true
		end
	end
	idx += 1
	puts "#{totalints}/#{idx}"
end

puts "Size:#{sum.size}"
#puts "#{sum.keys}"