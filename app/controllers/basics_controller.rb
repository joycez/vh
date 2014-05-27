class BasicsController < ApplicationController

	def home
		col_num = 4
		file = File.read('lib/data.json')
		genera = JSON.parse(file)
		@tabs = ('A'..'Z').to_a
		@genera_dict = {}
		initials_set = Set.new
		genera['genera'].each do |item|
			initial = item[0][0]
			if not initials_set.include? initial
				initials_set << initial
				@genera_dict[initial] = []
			end
			@genera_dict[initial] << item
		end
		@genera_dict_split = {}
		@genera_dict.keys.each do |k|
			@genera_dict_split[k] = []
			#q = @genera_dict[k].length/col_num
			# q = 0
			# @genera_dict[k].each do |i|
			# 	q += i[]
			# end
			# puts "***************" + "k:" + k.to_s + "q:" +q.to_s + "**************"
			# puts @genera_dict[k][0...q]
			# @genera_dict_split[k] = [@genera_dict[k][0...q], @genera_dict[k][q...2*q],
			# 													@genera_dict[k][2*q...3*q], @genera_dict[k][3*q..-1]]
			@genera_dict_split[k] = []
			#q = @genera_dict[k].length/col_num
			len = 0
			@genera_dict[k].each do |i|
				len += i[1].length
			end
			q = len/4
			sp = [q, 2*q, 3*q, len]
			for i in 0..2
				if len%4 > i
					for j in i..3
						sp[j] += 1
					end
				end
			end

			col = 0
			cnt = 0
			arr = []
			@genera_dict[k].each do |item|
				if cnt + item[1].length < sp[col]
					arr << item
					cnt += item[1].length
				else
					rem = 0
					arr << [item[0], item[1][0...sp[col]-cnt]]
					rem += (sp[col] - cnt)
					@genera_dict_split[k] << arr
					col += 1
					arr = []
					while col < 4 and item[1].length - rem > 0 and item[1].length - rem >= sp[col]-sp[col-1]
						arr << [item[0]+' (Cont.)', item[1][rem,sp[col]-sp[col-1]]]
						col += 1
						@genera_dict_split[k] << arr
						arr = []
						rem += sp[col]-sp[col-1]
					end

					if rem < item[1].length
						arr << [item[0]+' (Cont.)', item[1][rem..-1]]
					end
					cnt += item[1].length
				end
			end
			if arr.length > 0
				@genera_dict_split[k] << arr
			end

		end


	end

	def search
	end

end
