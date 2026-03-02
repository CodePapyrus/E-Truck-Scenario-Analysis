# Clear the data frame
order_for_CP <- order_for_CP[0, ]

order_for_CP <- read.csv("data/cleaned_data.csv")

# Input fixed parameters: average speed, truck load capacity, truck space, mileage range, fleet composition ratio.
# By default, conventional trucks have no range limitations.
average_speed_for_cp <- 60 # km/h
space_limitations <- 400000 # vehicle space limit
weight_limitations <- 2500 # vehicle weight limit
mileage_duration <- 500000 # vehicle range (km) (set to a large value if no limit)
effective_time <- 9999999999 # maximum allowed transport time for products without refrigeration

temp_accumulated_transportation_time <- 0 # accumulated time
temp_accumulated_weight <- 0 # accumulated weight
temp_accumulated_volume <- 0 # accumulated volume
temp_accumulated_distance <- 0 # accumulated distance

# Vehicle fleet parameters
num_of_truck <- 2         # number of conventional trucks
num_of_ref_truck <- 2     # number of refrigerated trucks
num_of_BET <- 2           # number of battery electric trucks (BET)
num_of_ref_BET <- 2       # number of refrigerated BET

truck_allocation <- data.frame(
  truck_serial_number = numeric(0), # vehicle serial number for this delivery
  weight_record = numeric(0),       # cumulative weight carried by this vehicle
  volume_record = numeric(0),       # cumulative volume
  distance_record = numeric(0),     # cumulative distance
  time_record = numeric(0)          # cumulative time
)

truck_num <- 1 # start with the first vehicle

# Assign delivery routes and allocate vehicles
num_delivery_order <- nrow(order_for_CP) # number of delivery points in this area

for (e in 1:num_delivery_order) { # iterate over each delivery point
  
  # Check constraints sequentially
  if (temp_accumulated_weight < weight_limitations) {          # weight limit check
    if (temp_accumulated_volume < space_limitations) {        # volume limit check
      if (temp_accumulated_distance < mileage_duration) {     # range limit check
        if (temp_accumulated_transportation_time < effective_time) { # time limit check
          
          # Assign current vehicle to this delivery point
          truck_allocation[e, 1] <- truck_num
          
          # Update accumulated loads
          temp_accumulated_weight <- temp_accumulated_weight + order_for_CP[e, 4]
          temp_accumulated_volume <- temp_accumulated_volume + order_for_CP[e, 5]
          temp_accumulated_distance <- temp_accumulated_distance + order_for_CP[e, 3]
          temp_accumulated_transportation_time <- temp_accumulated_transportation_time + order_for_CP[e, 6]
          
        } else { # time limit exceeded
          truck_num <- truck_num + 1          # move to next vehicle
          truck_allocation[e, 1] <- truck_num
          
          # Reset accumulated values starting from this point
          temp_accumulated_weight <- order_for_CP[e, 4]
          temp_accumulated_volume <- order_for_CP[e, 5]
          temp_accumulated_distance <- order_for_CP[e, 3]
          temp_accumulated_transportation_time <- order_for_CP[e, 6]
        }
      } else { # range limit exceeded
        truck_num <- truck_num + 1
        truck_allocation[e, 1] <- truck_num
        
        temp_accumulated_weight <- order_for_CP[e, 4]
        temp_accumulated_volume <- order_for_CP[e, 5]
        temp_accumulated_distance <- order_for_CP[e, 3]
        temp_accumulated_transportation_time <- order_for_CP[e, 6]
      }
    } else { # volume limit exceeded
      truck_num <- truck_num + 1
      truck_allocation[e, 1] <- truck_num
      
      temp_accumulated_weight <- order_for_CP[e, 4]
      temp_accumulated_volume <- order_for_CP[e, 5]
      temp_accumulated_distance <- order_for_CP[e, 3]
      temp_accumulated_transportation_time <- order_for_CP[e, 6]
    }
  } else { # weight limit exceeded
    truck_num <- truck_num + 1
    truck_allocation[e, 1] <- truck_num
    
    temp_accumulated_weight <- order_for_CP[e, 4]
    temp_accumulated_volume <- order_for_CP[e, 5]
    temp_accumulated_distance <- order_for_CP[e, 3]
    temp_accumulated_transportation_time <- order_for_CP[e, 6]
  }
  
  # Record current accumulated values for this vehicle
  truck_allocation[e, 2] <- temp_accumulated_weight
  truck_allocation[e, 3] <- temp_accumulated_volume
  truck_allocation[e, 4] <- temp_accumulated_distance
  truck_allocation[e, 5] <- temp_accumulated_transportation_time
  
} # end of for loop

# Write initial results
write.csv(truck_allocation, file = "result_for_analysis.csv", row.names = TRUE)
