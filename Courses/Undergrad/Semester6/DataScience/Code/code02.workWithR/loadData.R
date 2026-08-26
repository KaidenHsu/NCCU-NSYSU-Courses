uciCar <- read.table(  	# Note: 1 
   'https://raw.githubusercontent.com/WinVector/Examples/main/dfiles/car.data.csv', 	# Note: 2 
   sep=',', 	# Note: 3 
   header=T 	# Note: 4 
   )

# Always Exploring your data first
class(uciCar)
summary(uciCar)
dim(uciCar)
