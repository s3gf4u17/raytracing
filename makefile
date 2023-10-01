default:
	g++ source/main.cpp -o build -Ilibrary && ./build > test.ppm

release:
	g++ source/main.cpp -o release -Ilibrary -O3 && ./release > test.ppm
	# 3m23.681s - real
	# 0m43.498s - real with bvh