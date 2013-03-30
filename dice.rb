a = []
hist = {}

for i in 2..12 do
  hist[i] = 0
end


100.times do
  d1 = rand(1..6)
  d2 = rand(1..6)

  sum = d1 + d2

  a << sum

end

a.each{ |i| hist[i] += 1}

puts hist

hist.each { |k,v| puts k.to_s + ": " + "*"*v }
