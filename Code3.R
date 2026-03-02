#将两组代码结合起来，再分别计算和比较三个算法的各项指标

#################这里是（111）《碳排放&货损结果比较》与（222）Untitled1两部分代码的结合。最后汇总出理想结果。###############################################

#输入相关数据
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/baoshan_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/changning_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/chongming_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/fengxian_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/hongkou_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/huangpu_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/jiading_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/jingan_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/jinshan_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/minghang_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/pudong_jiaoqu_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/pudong_shiqu_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/putuo_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/qingpu_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/songjiang_1.csv", header = TRUE)
#transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/xuhui_1.csv", header = TRUE)
transportation_info <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/yangpu_1.csv", header = TRUE)





fiol_efficient <- 2.7251 #燃油系数
fuel_cost <- 0.07 #货车油耗

ceta <- 0.0000035#冷藏设备单位碳排放

num_of_row <- nrow(transportation_info) #汇总有多少行

#货车数量
total_num_of_truck <- transportation_info[num_of_row,2] #输入车辆数据

#各车型比例
ratio_rt <- 0
ratio_nrt <- 0
ratio_ret <- 0.5
ratio_nret <- 0.5

########################################################################################################
#（222）以下补充(222)的各项基础数据
########################################################################################################

#基础数据1
LC <- 0 #货损成本，和货物参数有关
FC <- 100#固定成本，基本不变
OC <- log(total_num_of_truck, base = exp(1))#运营成本，指数函数关系,与车辆数有关
TC <- 0 #运输成本，EP,CDP算法
OSC <- 0 #外包成本，CP算法


#基础数据2
utc_rt <- 0.09 #冷藏货车(ref_truck)的单位油耗
utc_nrt <- 0.07 #非冷藏货车(non_ref_truck)的单位油耗 
utc_ret <- 0.3 #冷藏电动货车（ref_elec_truck）的单位电耗  
utc_nret <- 0.2 #非冷藏电动货车（non_ref_elec_truck）的单位电耗  

#基础数据3  
P_oil <- 7.98 #油的单价
P_ele <- 6 #电的单价（工业用电）  

#基础数据4
ZZ1 <- 0
distance_ZZ1 <- 0
ZZ2 <- 0
distance_ZZ2 <- 0
ZZ3 <- 0
distance_ZZ3 <- 0
ZZ4 <- 0
distance_ZZ4 <- 0

###########################################################################################################
#（222）以上补充(222)的各项基础数据
###########################################################################################################


#计算各车型数量
num_of_ref_truck <- floor(total_num_of_truck * ratio_rt) #2
num_of_BET <- floor(total_num_of_truck * ratio_nret) #3
num_of_ref_BET <- floor(total_num_of_truck * ratio_ret) #4
num_of_truck <- total_num_of_truck - num_of_BET - num_of_ref_BET - num_of_ref_truck #1

#时间窗设置
t_k <- 500 #超过这个时间的货物就失效了，视为货损。

#设置货损时间参数
cargo_damage_EP <- 0 #EP算法下的初始货损为0
cargo_damage_CDP <- 0 #CDP……
cargo_damage_CP <- 0 #CP……

#分配车辆的算法

#EP算法，优先REF_BET,之后再rt【4321】
truck_order_EP <- data.frame(
  truck_order_EP = c(0),
  truck_type_EP = c(0)
)

for (q in 1:num_of_row) { #4
  truck_order_EP[q,1] <- q
  truck_order_EP[q,2] <- 4
}
for (q in num_of_ref_BET+1:num_of_BET + num_of_ref_BET) { #3
  truck_order_EP[q,1] <- q
  truck_order_EP[q,2] <- 3
}
for (q in num_of_BET + num_of_ref_BET +1:num_of_BET + num_of_ref_BET + num_of_ref_truck) {#2
  truck_order_EP[q,1] <- q
  truck_order_EP[q,2] <- 2
}
for (q in num_of_BET + num_of_ref_BET + num_of_ref_truck + 1:num_of_BET + num_of_ref_BET + num_of_ref_truck + num_of_truck) {#1
  truck_order_EP[q,1] <- q
  truck_order_EP[q,2] <- 1
}



#CDP算法，优先配送REF货物【4231】
truck_order_CDP <- data.frame(
  truck_order_CDP = c(0),
  truck_type_CDP = c(0)
)

for (q in 1:num_of_row) { #4
  truck_order_CDP[q,1] <- q
  truck_order_CDP[q,2] <- 4
}
for (q in num_of_ref_BET+1:num_of_ref_truck+ num_of_ref_BET) { #2
  truck_order_CDP[q,1] <- q
  truck_order_CDP[q,2] <- 2
}
for (q in num_of_ref_truck+ num_of_ref_BET +1:num_of_BET + num_of_ref_BET + num_of_ref_truck) {#3
  truck_order_CDP[q,1] <- q
  truck_order_CDP[q,2] <- 3
}
for (q in num_of_BET + num_of_ref_BET + num_of_ref_truck + 1:num_of_BET + num_of_ref_BET + num_of_ref_truck + num_of_truck) {#1
  truck_order_CDP[q,1] <- q
  truck_order_CDP[q,2] <- 1
}

#############################################################
#EP算法
E1_EP <- 0 #油车行驶碳排放
E2_EP <- 0 #冷藏设备碳排放
E3_EP <- 0 #其他碳排放

#计算油车行驶产生的碳排放
#先判断并计算油车的碳排放
for (u in 1:num_of_row) {#每一个配送点都计算过去
  if (transportation_info[u,2] > num_of_BET + num_of_ref_BET) {#判断是否为油车运输；【原理是：先安排的电车，计算剩下油车的车辆】
    #是油车就计算碳排放
    E1_EP <- E1_EP + fiol_efficient * fuel_cost * transportation_info[u,5]
  }
}

#再判断和计算冷藏设备的碳排放
for (v in 1:num_of_row) {#设定为各配送点循环
  
  #先判断冷藏设备的碳排放情况  
  if (truck_order_EP[v,2] == 2) {#判断是否为ref_truck,累计冷藏设备碳排放
    
    E2_EP <- E2_EP + transportation_info[v,3] * transportation_info[v,5] * ceta
    
  }
  if (truck_order_EP[v,2] == 4) {#判断是否为ref_BET,累计冷藏设备碳排放
    
    E2_EP <- E2_EP + transportation_info[v,3] * transportation_info[v,5] * ceta
    
  }
  
  
  #判断和计算货损情况，超过有效时间的部分，需计算货损
  if (truck_order_EP[v,2] == 1) {#判断是否为conventional_truck，并计算货损 =>1
    #超过失效时间的货物就是无效的
    if (transportation_info[v,6] > t_k) {#当货物超时，计算货损
      cargo_damage_EP <- cargo_damage_EP + transportation_info[v,3] - transportation_info[v-1,3]
      #累计货损
    }
  }
  
  if (truck_order_EP[v,2] == 3) {#判断是否为BET，并计算货损 =>3
    #超过失效时间的货物就是无效的
    if (transportation_info[v,6] > t_k) {#当货物超时，计算货损
      cargo_damage_EP <- cargo_damage_EP + transportation_info[v,3] - transportation_info[v-1,3]
      #累计货损
    }
  }
  
}


E3_EP <- E1_EP + E2_EP #EP算法下，碳排放累计值
######################################################################################
#（222）以下补充(222)的EP算法的成本
######################################################################################

#EP算法
LC_EP <-  cargo_damage_EP #货损成本
FC_EP <-  FC #固定成本
OC_EP <-  OC #运营成本

for (i in 1:num_of_row) { #每个配送点循环过去【4321】，EP按照这个顺序【ret;nret;rt;nrt】
  if (transportation_info[i,2] == 1) { #ret
    distance_ZZ1 <- transportation_info[i,5]  
  }
  ZZ1 <- distance_ZZ1 * utc_ret * P_ele
  
  if (transportation_info[i,2] == 2) { #nret
    distance_ZZ2 <- transportation_info[i,5]  
  }
  ZZ2 <- distance_ZZ2 * utc_nret * P_ele
  
  if (transportation_info[i,2] == 3) { #rt
    distance_ZZ3 <- transportation_info[i,5]  
  }
  ZZ3 <- distance_ZZ3 * utc_rt * P_oil
  
  if (transportation_info[i,2] == 4) { #nrt
    distance_ZZ4 <- transportation_info[i,5]  
  }
  ZZ4 <- distance_ZZ4 * utc_nrt * P_oil
}

TC_EP <- ZZ1 + ZZ2 + ZZ3 + ZZ4 #EP运输成本汇总 
OSC_EP <- 0 #外包成本

Z2_EP <- LC_EP + FC_EP + OC_EP + TC_EP + OSC_EP #CDP算法成本计算

######################################################################################
#（222）以上补充(222)的EP算法的成本
######################################################################################


#CDP算法下的碳排放情况。
E1_CDP <- 0
E2_CDP <- 0
E3_CDP <- 0

# CDP算法
# 碳排放情况汇总 
# 先计算油车的碳排放情况
for (v in 1:num_of_row) { #循环每个配送点。 4231顺序。
  
  #先判断是否为燃油车
  if (truck_order_CDP[v,2] == 4) { #是否为ref_BET  冷藏设备碳排放
    E2_CDP <- E2_CDP + transportation_info[v,3] * transportation_info[v,5] * ceta #冷藏设备碳排放
    
  }
  
  #再计算冷藏设备的碳排放情况
  if (truck_order_CDP[v,2] == 2) { #是否为ref_truck  车辆+冷藏设备碳排放
    E2_CDP <- E2_CDP + transportation_info[v,3] * transportation_info[v,5] * ceta #冷餐设备碳排放
    E1_CDP <- E1_CDP + fiol_efficient * fuel_cost * transportation_info[v,5] #燃油车碳排放
    
  }
  
  #同时计算产品的货损
  if (truck_order_CDP[v,2] == 3) { #是否为BET  货损
    #超过失效时间的货物是无效的
    if (transportation_info[v,6] > t_k) { #货物超时,计算货损
      cargo_damage_CDP <- cargo_damage_CDP + transportation_info[v,3] -transportation_info[v-1,3]
      #累计货损
    }  
    
  }
  
  
  if (truck_order_CDP[v,2] == 1) { #是否为conventional_truck  车辆+货损
    #超过失效时间的货物是无效的
    if (transportation_info[v,6] > t_k) { #货物超时，计算货损
      cargo_damage_CDP <- cargo_damage_CDP + transportation_info[v,3] -transportation_info[v-1,3]
      #累计货损
    }  
    E1_CDP <- E1_CDP + fiol_efficient * fuel_cost * transportation_info[v,4] #燃油车碳排放
  }  
  
}


E3_CDP <- E1_CDP + E2_CDP #CDP算法下，碳排放累计值

#####################################################################################################
#（222）以下补充(222)的CDP算法的成本
#####################################################################################################

#CDP算法
LC_CDP <- cargo_damage_CDP #货损成本
FC_CDP <- FC #固定成本 
OC_CDP <- OC #运营成本  

for (i in 1:num_of_row) { #每个配送点检查过去【4231】，CDP按照这个顺序【ret;rt;nret;nrt】
  if (transportation_info[i,2] == 1) {#ret
    distance_ZZ1 <- transportation_info[i,5]
  }
  ZZ1 <- distance_ZZ1 * utc_ret * P_ele
  
  if (transportation_info[i,2] == 2) {#rt
    distance_ZZ2 <- transportation_info[i,5] 
  }
  ZZ2 <- distance_ZZ2 * utc_rt * P_oil
  
  if (transportation_info[i,2] == 3) {#nret
    distance_ZZ3 <- transportation_info[i,5]
  }
  ZZ3 <- distance_ZZ3 * utc_nret * P_ele
  
  if (transportation_info[i,2] == 4) {#nrt
    distance_ZZ4 <- transportation_info[i,5] 
  }
  ZZ4 <- distance_ZZ4 * utc_nrt * P_oil
}

TC_CDP <- ZZ1 + ZZ2 + ZZ3 + ZZ4 #CDP运输成本汇总
OSC_CDP <- 0 #外包成本

Z1_CDP <- LC_CDP + FC_CDP + OC_CDP + TC_CDP + OSC_CDP #CDP算法成本计算

######################################################################################################
#（222）以上补充(222)的CDP算法的成本
######################################################################################################
#CP算法 选择最最合适的承包商，相关的问题还是比较常见的


#选择带冷藏设备的电动货车 & 公司再把业务外包给员工。成本会高很多，但是碳排放和货损会小很多


#冷藏设备碳排放

E1_CP <- 0
E2_CP <- 0
E3_CP <- 0 

for (v in 1:num_of_row) { #循环每个点
  E2_CP <- E2_CP + transportation_info[v,3] * transportation_info[v,5] * ceta #计算相关的货损情况
  
}

E3_CP <- E1_CP + E2_CP #汇总碳排放数值

#####################################################################################################
#（222）以下补充(222)的CP算法的成本
#####################################################################################################

#CP算法
LC_CP <-  cargo_damage_CP #货损成本
FC_CP <-  FC #固定成本
OC_CP <-  OC #运营成本
TC_CP <-  0 #运输成本
OSC_CP <- 0 #预设的外包成本

OSC_Cost_single_truck_start <- 65 #外包单车成本（起步价(5公里)）
OSC_Cost_single_truck_continue <- 4 #超出5公里的单价（元/公里）
temp_num_distance <- 0 #临时数据

for (j in 1:total_num_of_truck) { #循环每一辆配送车辆
  for (i in 1:num_of_row) { #循环每一个配送点
    
    if (transportation_info[i,2] == j) { #检查是不是同一辆车
      temp_num_distance <- transportation_info[i,5] #将数据放进去 
    }  
    
  }
  #在所有点循环完后，计算这辆车的外包成本（运输费用）
  
  OSC_CP <- OSC_CP + OSC_Cost_single_truck_start + OSC_Cost_single_truck_continue * (temp_num_distance - 5) #这个计算每一辆车的外包成本
  
} #结束配送车辆的循环

Z3_CP <- LC_CP + FC_CP + OC_CP + TC_CP + OSC_CP #CP算法成本计算

######################################################################################################
#（222）以上补充(222)的CP算法的成本
######################################################################################################

#清空数据框数据
for (cc in 1:num_of_row) {#循环每一个点，并清除数据
  truck_order_EP[cc,1] <- NA
  truck_order_EP[cc,2] <- NA
  truck_order_CDP[cc,1] <- NA
  truck_order_CDP[cc,2] <- NA
}



transportation_info <- transportation_info[0, ]

##########################################################
#输出计算结果
#EP算法
E3_EP #EP总碳排放
cargo_damage_EP #EP总货损

#CDP算法
E3_CDP #CDP总碳排放
cargo_damage_CDP #CDP总货损

#CP算法
E3_CP #CP总碳排放

#################################################################################################
#（222）以下新增加的成本核算，不同类型车辆数量
#################################################################################################
#结果展示
Z1_CDP
Z2_EP
Z3_CP

#显示四种车型各自数量
num_of_ref_truck
num_of_BET
num_of_ref_BET
num_of_truck
##################################################################################################
#（222）以上新增加的成本核算，不同类型车辆数量
##################################################################################################

carbon_damage_num <- data.frame(#设置配送顺序专用的数据框
  num_of_ref_truck = numeric(0),#ref_Truck
  num_of_BET = numeric(0),#BET
  num_of_ref_BET = numeric(0),#ref_BET
  num_of_truck = numeric(0),#Truck
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

carbon_damage_num[1,1] <- num_of_ref_truck
carbon_damage_num[1,2] <- num_of_BET
carbon_damage_num[1,3] <- num_of_ref_BET
carbon_damage_num[1,4] <- num_of_truck
carbon_damage_num[1,5] <- E3_CP 
carbon_damage_num[1,6] <- 0
carbon_damage_num[1,7] <- Z3_CP
carbon_damage_num[1,8] <- E3_CDP 
carbon_damage_num[1,9] <- cargo_damage_CDP 
carbon_damage_num[1,10] <- Z1_CDP 
carbon_damage_num[1,11] <- E3_EP
carbon_damage_num[1,12] <- cargo_damage_EP
carbon_damage_num[1,13] <- Z2_EP
  
  
  
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/baoshan_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/changning_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/chongming_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/fengxian_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/hongkou_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/huangpu_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/jiading_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/jingan_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/jinshan_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/minghang_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/pudong_jiaoqu_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/pudong_shiqu_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/putuo_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/qingpu_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/songjiang_1.csv", row.names = TRUE)
#write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/xuhui_1.csv", row.names = TRUE)
write.csv(carbon_damage_num,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure6/1/yangpu_1.csv", row.names = TRUE)



