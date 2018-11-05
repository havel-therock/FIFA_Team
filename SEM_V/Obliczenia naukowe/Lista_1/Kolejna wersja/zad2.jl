#!/usr/bin/env julia

#@author: Niebieski Kapturek, INF-FIFA-PPT-TEAM®
#@title: zad2

function zad2()
	kahanmacheps16 =
		Float16(
			Float16(
				3 * Float16(
					Float16(
						4/3
						)
					- 1
					)
				)
			- 1
			)

	kahanmacheps32 =
		Float32(
			Float32(
				3 * Float32(
					Float32(
						4/3
						)
					- 1
					)
				)
			- 1
			)
	kahanmacheps64 =
		Float64(
			Float64(
				3 * Float64(
					Float64(
						4/3
						)
					- 1
					)
				)
			- 1
			)

	println("kahanmacheps16=",kahanmacheps16,", eps(Float16)=",eps(Float16))
	println("kahanmacheps32=",kahanmacheps32,", eps(Float32)=",eps(Float32))
	println("kahanmacheps64=",kahanmacheps64,", eps(Float64)=",eps(Float64))

end

zad2()
