in_file = open("/home/eeb177-student/Desktop/eeb-177/lab-work/exercise-6/eBird.csv", encoding = "ISO-8859.15")
in_file.readline()
my_dict = {}
for line in in_file:
	split = line.split(",")
	species = split[3]
	family = split[8]
	my_dict[species] = family
in_file.close()  
