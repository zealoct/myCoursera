h = Hash.new false
h1 = Hash.new false
h1step = 5000
h2 = Hash.new false
h2step = 150
sum = Hash.new false

time1 = Time.now

File.open(ARGV[0]).each do |xx|
	x = xx.to_i
	h[x] = true
	h1[x/h1step] = true
	h2[x/h2step] = true
end

time2 = Time.now

puts "Read finishd with #{time2-time1}s"

idx = 0
hsize = h.size

puts "#{hsize}/0"
skip = 0

time1 = Time.now
h.keys.each do |x|
	idx+=1
	if idx%10000==0 then
		puts "#{hsize}/#{idx}"
		skip = 0
	end

	# detect whether a possible number exists with h1
	# as h1step>2w, most possible that s1==t1
	# not possible that t1-s1>1

	s1 = (-x-10000)/h1step
	t1 = (-x+10000)/h1step
	(s1..t1).each do |j|
		unless h1[j] then 
			next
		end

		a1 = b1 = 0
		if s1 == t1 then
			# -x-10000 .. -x+10000
			a1 = -x-10000
			b1 = -x+10000
		elsif j==s1 then
			# -x-10000 .. (s1+1)*h1step-1
			a1 = -x-10000
			b1 = (s1+1)*h1step-1
		elsif j==t1 then
			# t1*h1step .. -x+10000
			a1 = t1*h1step 
			b1 = -x+10000
		else
			a1 = j*h1step 
			b1 = (j+1)*h1step-1
		end
		# detect that a number exists at [a1..b1]
		# the length of [a1..b1] may varies from 1 to 2w

		# further refine the range [a1..b1] with h2
		#a1 = -x-10000
		#b1 = -x+10000

		s2 = a1/h2step
		t2 = b1/h2step
		(s2..t2).each do |i| 
			unless h2[i] then 
				next
			end

			a2 = b2 = 0
			if s2==t2 then 
				a2 = a1 
				b2 = b1
			elsif i==s2 then 
				# a1 .. (s2+1)*h2step-1
				a2 = a1
				b2 = (s2+1)*h2step-1
			elsif i==t2 then
				# t2*h2step .. b1
				a2 = t2*h2step 
				b2 = b1
			else
				# i*h2step .. (i+1)*h2step-1
				a2 = i*h2step 
				b2 = (i+1)*h2step-1
			end

			# lengh of [a2..b2] should be less than h2step
			(a2..b2).each do |y|
				if h[y] then 
					sum[x+y] = true
				end
			end
		end
	end
end
time2 = Time.now
puts "Size:#{sum.size}"
puts "Finished with #{time2-time1}s"