require "JSON"
require "Set"

		col_num = 4
		file = File.read('data.json')
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
			len = 0
			@genera_dict[k].each do |i|
				len += i[1].length+1
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
				if cnt + item[1].length + 1 < sp[col]
					arr << item
					cnt += item[1].length + 1
				else
					rem = sp[col] - cnt - 1
					arr << [item[0], item[1][0..rem]]

					@genera_dict_split[k] << arr
					col += 1
					arr = []

					if rem < item[1].length
						arr << [item[0], item[1][rem..-1]]
						cnt += item[1].length + 1
					end
				end
			end
			if arr.length > 0
				@genera_dict_split[k] << arr
			end
			#puts @genera_dict[k][0...q]
			#@genera_dict_split[k] << [@genera_dict[k][0...q], @genera_dict[k][q...2*q],
															#@genera_dict[k][2*q...3*q], @genera_dict[k][3*q..-1]]
		end
		#puts @genera_dict_split["A"].length