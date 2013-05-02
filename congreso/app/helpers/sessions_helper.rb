module SessionsHelper

	def posrel(bks,bk)		
		(bk.pos - bks[0].pos).to_f / (bks[-1].pos - bks[0].pos)
	end

	def match(tbks, bks)		
		if tbks.length < 5
			i=0; j=0		
			while i < tbks.length and j<bks.length
				if i<tbks.length and posrel(tbks,tbks[i]) < posrel(bks,bks[j])
					puts "#{posrel(tbks,tbks[i])}\t"
					i += 1
				elsif j<bks.length and posrel(tbks,tbks[i]) > posrel(bks,bks[j])
					puts "\t\t#{posrel(bks,bks[j])}"
					j += 1
				else
					puts "#{posrel(tbks,tbks[i])}\t#{posrel(bks,bks[j])}"
					i += 1
					j += 1
				end
			end
			#require 'debugger'; debugger
		end
		return if tbks.length <= 2 or bks.length <= 2
		puts "#{tbks.length} - #{bks.length}"
		tbk = tbks[1]
		bk = bks[1...bks.length-1].min_by { |bk| (posrel(bks,bk) - posrel(tbks,tbk)).abs }
		i = bks[1...bks.length-1].index(bk)
		tbk.bookmark = bk
		bk.matchtyp = 'auto'
		match(tbks[1...tbks.length],bks[i+1...bks.length])
	end

	# def match_cost(match)
	# 	(match[0][:pos] - match[1][:pos]).abs
	# end

	# def fix(bs)
	# 	[bs[0]] + bs[1..bs.length].collect {|b| {:pos => (b[:pos] - bs[0][:pos]) / (1 - bs[0][:pos]) }}
	# end


	# def bookmarks_match(bs1, bs2)
	# 	return [[],0.0] if bs1.length == 0 or bs2.length == 0

	# 	bestmatch = []
	# 	bestcost = 99999
	# 	bs1.each_with_index do |b1,i|
	# 		bs2bis = bs2.select {|b2| b2[:pos] >= b1[:pos]}
	# 		if bs2bis.length > 0			
	# 			match = [[b1,bs2bis[0]]]
	# 			bs2bis = fix(bs2bis)
	# 			inner_match,inner_cost = bookmarks_match(bs1[i+1..bs1.length],bs2bis[1..bs2bis.length])
	# 			match = match + inner_match
	# 			cost = match_cost(match[0]) + inner_cost
	# 			if cost < bestcost
	# 				bestcost = cost
	# 				bestmatch = match
	# 			end
	# 		end
	# 	end
	# 	[bestmatch,bestcost]
	# end

end
