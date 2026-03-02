# Direct data input
library("igraph")

# Input data
distance <- read.csv("data/raw_data.csv")          # CSV file with customer distances
cargo_demand <- read.csv("data/raw_data.csv")      # CSV file with customer demand data; 1 = normal product, 2 = refrigerated product
cargo_infor <- read.csv("data/raw_data.csv")       # CSV file with basic product information

cargo_weight_1 <- cargo_infor[1,1]                 # weight of product type 1
cargo_weight_2 <- cargo_infor[1,2]                  # weight of product type 2
cargo_volume_1 <- cargo_infor[1,3]                  # volume of product type 1
cargo_volume_2 <- cargo_infor[1,4]                  # volume of product type 2

num_node <- nrow(cargo_demand)                      # number of delivery points (should match Excel data)
average_speed <- 60                                  # average vehicle speed (km/h)
# cargo_threshold <-                                 # time threshold for cargo failure (not used)
# cargo_failure_rate <-                              # cargo failure rate (not used)

start_node <- 1                                      # define starting point
start_node_temp <- 1                                 # temporary starting point
# end_node <-                                        # define ending point (not used)

min_value <- 9999999                                 # initial minimum value for comparisons

# average unloading speed (hours per unit?)
average_unloading_speed <- 0.5

# Data frame to record route information
route <- data.frame(
  total_route = numeric(0),          # visited nodes
  single_distance = numeric(0),       # total distance traveled
  single_cargo_weight = numeric(0),    # cumulative cargo weight
  single_cargo_volume = numeric(0),    # cumulative cargo volume
  total_travel_time = numeric(0)       # total travel time
)

# Initialize first row with zeros; actual data start from row 2
route <- data.frame(
  total_route = c(1),
  single_distance = c(0),
  single_cargo_weight = c(0),
  single_cargo_volume = c(0),
  total_travel_time = c(0)
)

# Mark the starting point (important!)
route[2,1] <- start_node

# Set distances to the start node to a large value (9999999) to avoid re-selection
for (j in 1:num_node) {
  distance[j, start_node] <- 9999999
}

# Dijkstra algorithm begins
for (i in 2:num_node) {
  
  # Find the node with the smallest distance from the current start node
  for (k in 1:num_node) {
    if (min_value >= distance[start_node, k]) {
      min_value <- distance[start_node, k]
      start_node_temp <- k            # update temporary start node
    }
  }
  start_node <- start_node_temp
  
  # Record total distance for this step
  route[i, 2] <- min_value
  
  # Record the visited node
  route[i, 1] <- start_node
  
  # Accumulate cargo information
  route[i, 3] <- cargo_demand[i-1, 1] * cargo_weight_1 + cargo_demand[i-1, 2] * cargo_weight_2   # cumulative weight
  route[i, 4] <- cargo_demand[i-1, 1] * cargo_volume_1 + cargo_demand[i-1, 2] * cargo_volume_2    # cumulative volume
  
  # Cumulative time: travel time + unloading time for both product types
  route[i, 5] <- route[i, 2] / average_speed + cargo_demand[i, 1] / average_unloading_speed + cargo_demand[i, 2] / average_unloading_speed
  
  # Mark all distances to the current start node as large to avoid revisiting
  for (j in 1:num_node) {
    distance[j, start_node] <- 9999999
  }
  
  # Reset min_value for next iteration
  min_value <- 9999999
}

# Print results (for debugging)
print(route)
print(route[,1])

# Save the route table to a CSV file
write.csv(route, file = "output/cleaned_data.csv", row.names = TRUE)
