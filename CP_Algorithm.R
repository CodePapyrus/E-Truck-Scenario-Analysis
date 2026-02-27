#CP_Algorithm

#清空数据框的数据
order_for_CP <- order_for_CP[0, ]

#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/baoshan_1.csv")#输入计算好的运输顺序
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/changning_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/chongming_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/fengxian_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/hongkou_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/huangpu_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/jiading_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/jingan_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/jinshan_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/minghang_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/pudong_jiaoqu_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/pudong_shiqu_1.csv")#将几个区分别代入计算
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/putuo_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/qingpu_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/songjiang_1.csv")
#order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/xuhui_1.csv")
order_for_CP <- read.csv("C:/Users/Administrator/Desktop/test_data/results_analysis/CP/yangpu_1.csv")

#分别输入固定参数，平均速度；车型载重；车型空间；续航里程；车型构成比例。默认油车没有相关续航的限制。
average_speed_for_cp <- 60 #公里/小时
space_limitations <- 400000 #车辆空间限制
weight_limitations <- 2500 #车辆重量限制
mileage_duration <- 500000 #车辆续航里程为400公里
effective_time <- 9999999999 #无冷藏设备情况下的，运输商品的有效时间

temp_accumulated_transportation_time <- 0 #累计时间
temp_accumulated_weight <- 0 #累计重量
temp_accumulated_volume <- 0 #累计体积
temp_accumulated_distance <- 0 #累计距离


#车型及数量相关参数
num_of_truck <- 2 #truck的数量
num_of_ref_truck <- 2 #ref_truck的数量
num_of_BET <- 2 #BET的数量
num_of_ref_BET <- 2 #ref_BET的数量

truck_allocation <- data.frame(#设置配送顺序专用的数据框
  truck_serial_number = numeric(0),#记录配送的车辆
  weight_record = numeric(0),#记录重量
  volume_record = numeric(0),#记录容积
  distance_record = numeric(0),#记录距离
  time_record = numeric(0)#记录时间
)

truck_num <- 1 #第一辆车开始

#分配配送线路，分配车辆



#判断车辆的行驶情况
num_delivery_order <- nrow(order_for_CP) #匹配区域内所有需要配送的点

for (e in 1:num_delivery_order) {#每个点都要依次循环过去
  
  #四项分别检查一下
 
  if (temp_accumulated_weight < weight_limitations) {#判断载重是否符合规定
    if (temp_accumulated_volume < space_limitations) {#判断空间是否符合规定
      if (temp_accumulated_distance < mileage_duration) {#判断续航里程是否达标
        if (temp_accumulated_transportation_time < effective_time) {#判断时间是否符合要求,时间参数该怎么判断？
          
          #计入配送顺序
          truck_allocation[e,1] <- truck_num
          
          
          temp_accumulated_weight <- temp_accumulated_weight + order_for_CP[e,4] #累计的载重量
          temp_accumulated_volume <- temp_accumulated_volume + order_for_CP[e,5]#累计的空间量
          temp_accumulated_distance <- temp_accumulated_distance + order_for_CP[e,3]#累计的距离
          temp_accumulated_transportation_time <- temp_accumulated_transportation_time + order_for_CP[e,6]#累计的时间
          
        }else{#载重不符合规定
          truck_num <- truck_num + 1 #车辆的序号更新
          truck_allocation[e,1] <- truck_num
          
          temp_accumulated_weight <- order_for_CP[e,4] #载重量重新开始计算
          temp_accumulated_volume <- order_for_CP[e,5]#空间重新开始计算
          temp_accumulated_distance <- order_for_CP[e,3]#距离重新开始计算
          temp_accumulated_transportation_time <- order_for_CP[e,6]#时间重新开始计算
          
        }
      }else{#空间不符合规定
        truck_num <- truck_num + 1 #车辆的序号更新
        truck_allocation[e,1] <- truck_num
        
        temp_accumulated_weight <- order_for_CP[e,4] #载重量重新开始计算
        temp_accumulated_volume <- order_for_CP[e,5]#空间重新开始计算
        temp_accumulated_distance <- order_for_CP[e,3]#距离重新开始计算
        temp_accumulated_transportation_time <- order_for_CP[e,6]#时间重新开始计算
        
      }
    } else{#续航不达标
      truck_num <- truck_num + 1 #车辆的序号更新
      truck_allocation[e,1] <- truck_num
      
      temp_accumulated_weight <- order_for_CP[e,4] #载重量重新开始计算
      temp_accumulated_volume <- order_for_CP[e,5]#空间重新开始计算
      temp_accumulated_distance <- order_for_CP[e,3]#距离重新开始计算
      temp_accumulated_transportation_time <- order_for_CP[e,6]#时间重新开始计算
      
    }
  }else{#时间不达标
    truck_num <- truck_num + 1 #车辆的序号更新
    truck_allocation[e,1] <- truck_num
    
    temp_accumulated_weight <- order_for_CP[e,4] #载重量重新开始计算
    temp_accumulated_volume <- order_for_CP[e,5]#空间重新开始计算
    temp_accumulated_distance <- order_for_CP[e,3]#距离重新开始计算
    temp_accumulated_transportation_time <- order_for_CP[e,6]#时间重新开始计算
    
  }

  truck_allocation[e,2] <- temp_accumulated_weight
  truck_allocation[e,3] <- temp_accumulated_volume
  truck_allocation[e,4] <- temp_accumulated_distance
  truck_allocation[e,5] <- temp_accumulated_transportation_time
  
  
#for循环结束
}


#最初结果的内容
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/results_analysis/truck_allocation/new_1.0/yangpu_1.csv", row.names = TRUE)

#下面是789图像，换参数用的【带时间窗】
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/baoshan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/changning_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/chongming_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/fengxian_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/hongkou_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/huangpu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/jiading_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/jingan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/jinshan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/minghang_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/pudong_jiaoqu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/pudong_shiqu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/putuo_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/qingpu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/songjiang_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/xuhui_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure789/weight_limitations=1/yangpu_1.csv", row.names = TRUE)

#下面是101112图像，换参数用的【不带时间窗】
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/baoshan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/changning_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/chongming_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/fengxian_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/hongkou_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/huangpu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/jiading_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/jingan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/jinshan_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/minghang_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/pudong_jiaoqu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/pudong_shiqu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/putuo_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/qingpu_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/songjiang_1.csv", row.names = TRUE)
#write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/xuhui_1.csv", row.names = TRUE)
write.csv(truck_allocation,file = "C:/Users/Administrator/Desktop/test_data/data_for_figure101112/mileage_duration=500/yangpu_1.csv", row.names = TRUE)





