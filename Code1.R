#这里直接输入数据
library("igraph")

#输入数据
distance <- read.csv("C:/Users/Administrator/Desktop/distance_x_y.csv")#输入客户距离的csv文件
cargo_demand <- read.csv("C:/Users/Administrator/Desktop/test_data/demand/jiaoqu/jiading.csv") #输入客户需求数据的csv文件，1为普通商品，2为冷藏商品
cargo_infor <- read.csv("C:/Users/Administrator/Desktop/yangpu1_cargo_information.csv")#输入商品的基础信息

#【不可外传】修整客户的运输需求，删减一部分不存在的需求（普通货物&特殊货物）  【这两段暂时不需要了】

#删减不需要的普通货物数据
#for (i in 1:nrow(cargo_demand)) {#替换满足某某规则的数据
#  if (cargo_demand[i,1] <= 10){#小于等于10的都调整为0
#    cargo_demand[i,1] <- 0#小于等于10的都调整为0
#  }
#  if (cargo_demand[i,1] >= 80){#大于等于80的都调整为0
#    cargo_demand[i,1] <- 0#大于等于80的都调整为0
#  }
#}

#删减不需要的冷藏货物数据
#for (i in 1:nrow(cargo_demand)) {#替换满足某某规则的数据
#  if (cargo_demand[i,2] <= 10){#小于等于10的都调整为0
#    cargo_demand[i,2] <- 0#小于等于10的都调整为0
#  }
#  if (cargo_demand[i,2] >= 80){#大于等于80的都调整为0
#    cargo_demand[i,2] <- 0#大于等于80的都调整为0
#  }
#}
#数据调整结束

cargo_weight_1 <- cargo_infor[1,1]#定义货物的重量
cargo_weight_2 <- cargo_infor[1,2]
cargo_volume_1 <- cargo_infor[1,3]#定义货物的体积
cargo_volume_2 <- cargo_infor[1,4]

num_node <- nrow(cargo_demand)#输入需要配送的点，与excel数据对应
average_speed <- 60#车辆平均行驶速度（公里/小时）
#cargo_threshold <- #时间限制的货物失效的阈值
#cargo_failure_rate <- #货物失效率
  
start_node <- 1#定义出发点
start_node_temp <- 1#定义临时出发点
#end_node <- #定义结束点

min_value <- 9999999#设置初始的最小值,方便比较

#定义平均卸货速度
average_unloading_speed <- 0.5

#用于输出路径&运输货物信息记录
route <- data.frame(
  total_route = numeric(0),#经过点，1
  single_distance = numeric(0),#总行驶的距离，2
  single_cargo_weight = numeric(0),#累计货物重量，3
  single_cargo_volume = numeric(0),#累计货物体积，4
  total_travel_time = numeric(0)#总行驶时间，5
)

#为了之后的循环累计，将第一行统一设置为0。标准数字从第二行开始。
route <- data.frame( 
  total_route = c(1),  
  single_distance = c(0), 
  single_cargo_weight = c(0),  
  single_cargo_volume = c(0),  
  total_travel_time = c(0)  
)

#用于对始发点的标记@#￥%……&*（），这里要特别注意！！！！！！
route[2,1] <- start_node

for (j in 1:num_node) {
  distance[j,start_node] <- 9999999
} 


#dijkstra算法开始
for (i in 2:num_node) {
  
  #定义了比较最短路径的算法
  for (k in 1:num_node) { 
    if (min_value >= distance[start_node,k]) {#定义了一个最小值作为中间变量
      min_value <- distance[start_node,k]
      start_node_temp <- k#更新出发点
    }
  }
  start_node <- start_node_temp
  
  #print(min_value)#检查代码用
  #print(start_node)#检查代码用
  
  route[i,2] <-  min_value #汇总总路程的长度
  #print(route[i,2])#临时文件，用于修改相关数据；检查代码用
  
  route[i,1] <- start_node  #汇总运输路线
  
  #累计货物信息
  route[i,3] <- cargo_demand[i-1,1]*cargo_weight_1 + cargo_demand[i-1,2]*cargo_weight_2#累计重量
  route[i,4] <- cargo_demand[i-1,1]*cargo_volume_1 + cargo_demand[i-1,2]*cargo_volume_2#累计体积
  
  #累计的时间,距离除以平均行驶距离
  route[i,5] <- route[i,2]/average_speed + cargo_demand[i,1]/average_unloading_speed + cargo_demand[i,2]/average_unloading_speed
  
  #将这个点所有的距离值都修改为9999999(竖的一列全部改为9999999)
  for (j in 1:num_node) {
    distance[j,start_node] <- 9999999
  }
  
  #将min_value的变量更新为9999999
  min_value <- 9999999  
  
}

#print(distance)检查代码用
print(route)
print(route[,1])

write.csv(route,file = "C:/Users/Administrator/Desktop/route_covered_x_y.csv", row.names = TRUE)
 

