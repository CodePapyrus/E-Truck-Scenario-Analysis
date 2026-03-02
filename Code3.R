transportation_info <- read.csv("data_for_analysis.csv", header = TRUE)

fuel_efficiency <- 2.7251 # fuel efficiency coefficient
fuel_cost <- 0.07 # truck fuel consumption

ceta <- 0.0000035 # refrigeration equipment carbon emission per unit

num_of_row <- nrow(transportation_info) # total number of rows

# Number of trucks
total_num_of_truck <- transportation_info[num_of_row, 2] # input vehicle count

# Fleet composition ratios
ratio_rt <- 0
ratio_nrt <- 0
ratio_ret <- 0.5
ratio_nret <- 0.5

#########################################################################################
# (222) Below: supplementary basic data for (222)
#########################################################################################

# Basic data 1
LC <- 0 # loss cost (related to cargo parameters)
FC <- 100 # fixed cost (constant)
OC <- log(total_num_of_truck, base = exp(1)) # operational cost (exponential function, depends on number of vehicles)
TC <- 0 # transportation cost (EP, CDP algorithm)
OSC <- 0 # outsourcing cost (CP algorithm)

# Basic data 2
utc_rt <- 0.09 # unit fuel consumption of refrigerated truck (ref_truck)
utc_nrt <- 0.07 # unit fuel consumption of non‑refrigerated truck (non_ref_truck)
utc_ret <- 0.3 # unit electricity consumption of refrigerated electric truck (ref_elec_truck)
utc_nret <- 0.2 # unit electricity consumption of non‑refrigerated electric truck (non_ref_elec_truck)

# Basic data 3
P_oil <- 7.98 # price of oil (per unit)
P_ele <- 6   # price of electricity (industrial, per unit)

# Basic data 4
ZZ1 <- 0
distance_ZZ1 <- 0
ZZ2 <- 0
distance_ZZ2 <- 0
ZZ3 <- 0
distance_ZZ3 <- 0
ZZ4 <- 0
distance_ZZ4 <- 0

#########################################################################################
# (222) Above: supplementary basic data for (222)
#########################################################################################

# Calculate number of vehicles by type
num_of_ref_truck <- floor(total_num_of_truck * ratio_rt)   # type 2
num_of_BET <- floor(total_num_of_truck * ratio_nret)       # type 3
num_of_ref_BET <- floor(total_num_of_truck * ratio_ret)    # type 4
num_of_truck <- total_num_of_truck - num_of_BET - num_of_ref_BET - num_of_ref_truck # type 1

# Time window setting
t_k <- 500 # cargo is considered spoiled if transport time exceeds this threshold

# Cargo damage parameters
cargo_damage_EP <- 0   # initial damage under EP algorithm
cargo_damage_CDP <- 0  # initial damage under CDP algorithm
cargo_damage_CP <- 0   # initial damage under CP algorithm

# Vehicle allocation logic

# EP algorithm: priority order REF_BET, then nret, rt, nrt [4,3,2,1]
truck_order_EP <- data.frame(
  truck_order_EP = c(0),
  truck_type_EP = c(0)
)

for (q in 1:num_of_row) { # 4
  truck_order_EP[q, 1] <- q
  truck_order_EP[q, 2] <- 4
}
for (q in (num_of_ref_BET + 1):(num_of_BET + num_of_ref_BET)) { # 3
  truck_order_EP[q, 1] <- q
  truck_order_EP[q, 2] <- 3
}
for (q in (num_of_BET + num_of_ref_BET + 1):(num_of_BET + num_of_ref_BET + num_of_ref_truck)) { # 2
  truck_order_EP[q, 1] <- q
  truck_order_EP[q, 2] <- 2
}
for (q in (num_of_BET + num_of_ref_BET + num_of_ref_truck + 1):(num_of_BET + num_of_ref_BET + num_of_ref_truck + num_of_truck)) { # 1
  truck_order_EP[q, 1] <- q
  truck_order_EP[q, 2] <- 1
}

# CDP algorithm: priority order REF_BET, then rt, nret, nrt [4,2,3,1]
truck_order_CDP <- data.frame(
  truck_order_CDP = c(0),
  truck_type_CDP = c(0)
)

for (q in 1:num_of_row) { # 4
  truck_order_CDP[q, 1] <- q
  truck_order_CDP[q, 2] <- 4
}
for (q in (num_of_ref_BET + 1):(num_of_ref_truck + num_of_ref_BET)) { # 2
  truck_order_CDP[q, 1] <- q
  truck_order_CDP[q, 2] <- 2
}
for (q in (num_of_ref_truck + num_of_ref_BET + 1):(num_of_BET + num_of_ref_BET + num_of_ref_truck)) { # 3
  truck_order_CDP[q, 1] <- q
  truck_order_CDP[q, 2] <- 3
}
for (q in (num_of_BET + num_of_ref_BET + num_of_ref_truck + 1):(num_of_BET + num_of_ref_BET + num_of_ref_truck + num_of_truck)) { # 1
  truck_order_CDP[q, 1] <- q
  truck_order_CDP[q, 2] <- 1
}

########################################################################################
# EP algorithm
E1_EP <- 0 # carbon emissions from fuel trucks
E2_EP <- 0 # carbon emissions from refrigeration equipment
E3_EP <- 0 # other emissions (sum)

# Calculate emissions from fuel trucks
for (u in 1:num_of_row) {
  # If the vehicle index > (number of electric trucks), it is a fuel truck
  if (transportation_info[u, 2] > num_of_BET + num_of_ref_BET) {
    E1_EP <- E1_EP + fuel_efficiency * fuel_cost * transportation_info[u, 5]
  }
}

# Calculate emissions from refrigeration equipment and cargo damage
for (v in 1:num_of_row) {
  # Refrigeration equipment emissions
  if (truck_order_EP[v, 2] == 2) { # ref_truck
    E2_EP <- E2_EP + transportation_info[v, 3] * transportation_info[v, 5] * ceta
  }
  if (truck_order_EP[v, 2] == 4) { # ref_BET
    E2_EP <- E2_EP + transportation_info[v, 3] * transportation_info[v, 5] * ceta
  }

  # Cargo damage (spoilage)
  if (truck_order_EP[v, 2] == 1) { # conventional truck
    if (transportation_info[v, 6] > t_k) {
      cargo_damage_EP <- cargo_damage_EP + (transportation_info[v, 3] - transportation_info[v-1, 3])
    }
  }
  if (truck_order_EP[v, 2] == 3) { # BET
    if (transportation_info[v, 6] > t_k) {
      cargo_damage_EP <- cargo_damage_EP + (transportation_info[v, 3] - transportation_info[v-1, 3])
    }
  }
}

E3_EP <- E1_EP + E2_EP # total carbon emissions under EP

########################################################################################
# (222) Below: cost calculation for EP algorithm
########################################################################################

# EP algorithm costs
LC_EP <- cargo_damage_EP   # loss cost
FC_EP <- FC                # fixed cost
OC_EP <- OC                # operational cost

for (i in 1:num_of_row) {
  if (transportation_info[i, 2] == 1) { # ret
    distance_ZZ1 <- transportation_info[i, 5]
  }
  ZZ1 <- distance_ZZ1 * utc_ret * P_ele

  if (transportation_info[i, 2] == 2) { # nret
    distance_ZZ2 <- transportation_info[i, 5]
  }
  ZZ2 <- distance_ZZ2 * utc_nret * P_ele

  if (transportation_info[i, 2] == 3) { # rt
    distance_ZZ3 <- transportation_info[i, 5]
  }
  ZZ3 <- distance_ZZ3 * utc_rt * P_oil

  if (transportation_info[i, 2] == 4) { # nrt
    distance_ZZ4 <- transportation_info[i, 5]
  }
  ZZ4 <- distance_ZZ4 * utc_nrt * P_oil
}

TC_EP <- ZZ1 + ZZ2 + ZZ3 + ZZ4 # total transportation cost under EP
OSC_EP <- 0 # outsourcing cost

Z2_EP <- LC_EP + FC_EP + OC_EP + TC_EP + OSC_EP # total cost under EP

########################################################################################
# (222) Above: cost calculation for EP algorithm
########################################################################################

# CDP algorithm carbon emissions
E1_CDP <- 0
E2_CDP <- 0
E3_CDP <- 0

for (v in 1:num_of_row) {
  # Refrigeration emissions
  if (truck_order_CDP[v, 2] == 4) { # ref_BET
    E2_CDP <- E2_CDP + transportation_info[v, 3] * transportation_info[v, 5] * ceta
  }
  if (truck_order_CDP[v, 2] == 2) { # ref_truck
    E2_CDP <- E2_CDP + transportation_info[v, 3] * transportation_info[v, 5] * ceta
    E1_CDP <- E1_CDP + fuel_efficiency * fuel_cost * transportation_info[v, 5] # fuel truck emissions
  }

  # Cargo damage
  if (truck_order_CDP[v, 2] == 3) { # BET
    if (transportation_info[v, 6] > t_k) {
      cargo_damage_CDP <- cargo_damage_CDP + (transportation_info[v, 3] - transportation_info[v-1, 3])
    }
  }
  if (truck_order_CDP[v, 2] == 1) { # conventional truck
    if (transportation_info[v, 6] > t_k) {
      cargo_damage_CDP <- cargo_damage_CDP + (transportation_info[v, 3] - transportation_info[v-1, 3])
    }
    E1_CDP <- E1_CDP + fuel_efficiency * fuel_cost * transportation_info[v, 4] # fuel truck emissions
  }
}

E3_CDP <- E1_CDP + E2_CDP # total carbon emissions under CDP

########################################################################################
# (222) Below: cost calculation for CDP algorithm
########################################################################################

# CDP algorithm costs
LC_CDP <- cargo_damage_CDP
FC_CDP <- FC
OC_CDP <- OC

for (i in 1:num_of_row) {
  if (transportation_info[i, 2] == 1) { # ret
    distance_ZZ1 <- transportation_info[i, 5]
  }
  ZZ1 <- distance_ZZ1 * utc_ret * P_ele

  if (transportation_info[i, 2] == 2) { # rt
    distance_ZZ2 <- transportation_info[i, 5]
  }
  ZZ2 <- distance_ZZ2 * utc_rt * P_oil

  if (transportation_info[i, 2] == 3) { # nret
    distance_ZZ3 <- transportation_info[i, 5]
  }
  ZZ3 <- distance_ZZ3 * utc_nret * P_ele

  if (transportation_info[i, 2] == 4) { # nrt
    distance_ZZ4 <- transportation_info[i, 5]
  }
  ZZ4 <- distance_ZZ4 * utc_nrt * P_oil
}

TC_CDP <- ZZ1 + ZZ2 + ZZ3 + ZZ4
OSC_CDP <- 0

Z1_CDP <- LC_CDP + FC_CDP + OC_CDP + TC_CDP + OSC_CDP

########################################################################################
# (222) Above: cost calculation for CDP algorithm
########################################################################################

# CP algorithm: select the most suitable contractor (common practice)
# Using refrigerated electric trucks and outsourcing to employees.
# Higher cost, but lower emissions and spoilage.

# Refrigeration emissions
E1_CP <- 0
E2_CP <- 0
E3_CP <- 0

for (v in 1:num_of_row) {
  E2_CP <- E2_CP + transportation_info[v, 3] * transportation_info[v, 5] * ceta
}

E3_CP <- E1_CP + E2_CP

########################################################################################
# (222) Below: cost calculation for CP algorithm
########################################################################################

# CP algorithm costs
LC_CP <- cargo_damage_CP
FC_CP <- FC
OC_CP <- OC
TC_CP <- 0
OSC_CP <- 0 # preset outsourcing cost

OSC_Cost_single_truck_start <- 65   # base outsourcing cost per truck (first 5 km)
OSC_Cost_single_truck_continue <- 4 # additional cost per km beyond 5 km
temp_num_distance <- 0

for (j in 1:total_num_of_truck) {
  for (i in 1:num_of_row) {
    if (transportation_info[i, 2] == j) {
      temp_num_distance <- transportation_info[i, 5]
    }
  }
  # After scanning all points for this vehicle, calculate outsourcing cost
  OSC_CP <- OSC_CP + OSC_Cost_single_truck_start + OSC_Cost_single_truck_continue * (temp_num_distance - 5)
}

Z3_CP <- LC_CP + FC_CP + OC_CP + TC_CP + OSC_CP

########################################################################################
# (222) Above: cost calculation for CP algorithm
########################################################################################

# Clear temporary data frames
for (cc in 1:num_of_row) {
  truck_order_EP[cc, 1] <- NA
  truck_order_EP[cc, 2] <- NA
  truck_order_CDP[cc, 1] <- NA
  truck_order_CDP[cc, 2] <- NA
}

transportation_info <- transportation_info[0, ]

##########################################################
# Output results
# EP algorithm
E3_EP          # EP total carbon emissions
cargo_damage_EP # EP total cargo damage

# CDP algorithm
E3_CDP          # CDP total carbon emissions
cargo_damage_CDP # CDP total cargo damage

# CP algorithm
E3_CP           # CP total carbon emissions

########################################################################################
# (222) Below: newly added cost accounting, number of vehicles by type
########################################################################################
# Results display
Z1_CDP
Z2_EP
Z3_CP

# Display number of each vehicle type
num_of_ref_truck
num_of_BET
num_of_ref_BET
num_of_truck
########################################################################################
# (222) Above: newly added cost accounting, number of vehicles by type
########################################################################################

carbon_damage_num <- data.frame(
  num_of_ref_truck = numeric(0),
  num_of_BET = numeric(0),
  num_of_ref_BET = numeric(0),
  num_of_truck = numeric(0),
  CP_Carbon = numeric(0),
  CP_damage = numeric(0),
  CP_cost = numeric(0),
  CDP_Carbon = numeric(0),
  CDP_damage = numeric(0),
  CDP_cost = numeric(0),
  EP_Carbon = numeric(0),
  EP_damage = numeric(0),
  EP_cost = numeric(0)
)

carbon_damage_num[1, 1] <- num_of_ref_truck
carbon_damage_num[1, 2] <- num_of_BET
carbon_damage_num[1, 3] <- num_of_ref_BET
carbon_damage_num[1, 4] <- num_of_truck
carbon_damage_num[1, 5] <- E3_CP
carbon_damage_num[1, 6] <- 0
carbon_damage_num[1, 7] <- Z3_CP
carbon_damage_num[1, 8] <- E3_CDP
carbon_damage_num[1, 9] <- cargo_damage_CDP
carbon_damage_num[1,10] <- Z1_CDP
carbon_damage_num[1,11] <- E3_EP
carbon_damage_num[1,12] <- cargo_damage_EP
carbon_damage_num[1,13] <- Z2_EP

write.csv(carbon_damage_num, file = "final_result.csv", row.names = TRUE)
```
