lines = File.open(ARGV[0]).readlines

g = Hash.new

lines.each do |line| 
	tokens = line.split /\s/
	puts "tokens:#{tokens}"
	u = tokens.shift.to_i
	g[u] = Hash.new
	tokens.each do |t|
		v, w = t.split(",").map {|t| t.to_i}
		g[u][v] = w
	end
end

#puts "g:#{g}"

x = Hash.new false
a = Hash.new -1
b = Hash.new -1

x[1] = true
a[1] = 0

g[1].keys.each do |k|
	b[k] = g[1][k]
end

while x.size < g.size do
	#puts "============ite===========\n  x:#{x}\n  a:#{a}\n  b:#{b}\n"
	u = cost = -1
	# pick up the smallest edge
	b.each do |key, value| 
		if cost == -1 || value < cost then
			u = key
			cost = value 
		end
	end

	#puts "  pick up #{u}"

	x[u] = true 
	a[u] = cost
	b.delete u

	g[u].each do |v, w| 
		if !x[v] && (b[v] == -1 || a[u] + g[u][v] < b[v]) then 
			b[v] = a[u] + g[u][v]
		end
	end
end

#puts "Dij:#{a}"

puts "  7:#{a[7]}"
puts " 37:#{a[37]}"
puts " 59:#{a[59]}"
puts " 82:#{a[82]}"
puts " 99:#{a[99]}"
puts "115:#{a[115]}"
puts "133:#{a[133]}"
puts "165:#{a[165]}"
puts "188:#{a[188]}"
puts "197:#{a[197]}"

puts "#{a[7]},#{a[37]},#{a[59]},#{a[82]},#{a[99]},#{a[115]},#{a[133]},#{a[165]},#{a[188]},#{a[197]}"