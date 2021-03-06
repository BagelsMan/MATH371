%run the model multiple times, changing alpha/beta
close all
clear all

% num_viable_paths = zeros(2,5);
% num_drone1 = zeros(2,5);
% num_drone2 = zeros(2,5);
% num_drone3 = zeros(2,5);
% cost_by_storage = zeros(5,15);

%gamma = alpha/beta
cnt = 1;
% for gamma = [1e5:1e5]
%     beta = 0.000005;
%     alpha = gamma*beta;
%     
%     flight_paths
%     num = length(optimal_plan_idx);
%     num_viable_paths(1,cnt) = gamma;
%     num_viable_paths(2,cnt) = num;
%     
%     ind_path_drones1 = zeros(1,length(optimal_plan_idx));
%     ind_path_drones2 = zeros(1,length(optimal_plan_idx));
%     ind_path_drones3 = zeros(1,length(optimal_plan_idx));
%     for i=[1:length(optimal_plan_idx)]
%         [path,con,row] = get_path(optimal_plan_idx(i),drone_fleet^trips_all,size(all_all_cost));
%         ind_path_drone1(1,i) = sum(all_flight_drones(path,:,con)==0);
%         ind_path_drone2(1,i) = sum(all_flight_drones(path,:,con)==1);
%         ind_path_drone3(1,i) = sum(all_flight_drones(path,:,con)==2);
%     end
%     num_drone1(2,cnt) = sum(ind_path_drone1)/length(optimal_plan_idx);
%     num_drone2(2,cnt) = sum(ind_path_drone2)/length(optimal_plan_idx);
%     num_drone3(2,cnt) = sum(ind_path_drone3)/length(optimal_plan_idx);
%     num_drone1(1,cnt) = gamma;
%     num_drone2(1,cnt) = gamma;
%     num_drone3(1,cnt) = gamma;
%     
%     cost_by_storage(cnt,:) = cost_by_supply;
%     
%     cnt = cnt+1
% end

%run model with different drone fleet sizes
% diff_fleet_num = zeros(16,5);
% 
% for fleet = [2:5]
%     drone_fleet = fleet;
%     flight_paths
%     
%     %store the cost function outputs for each run
%     cost_by_loc = sum(all_all_cost,2)/length(optimal_plan_idx);
%     
%     diff_fleet_num(1,cnt) = fleet;
%     diff_fleet_num(2:16,cnt) = cost_by_loc;
%     
%     
%     cnt=cnt+1;
% end

%run model with different drone fleet sizes, keeping the location config
%the same
% diff_fleet_same_storage_avgcost = zeros(2,5);
% diff_fleet_same_storage_rangecost = zeros(2,5);
% for fleet = [2:5]
%     diff_fleet_same_storage_avgcost(1,cnt) = fleet;
%     diff_fleet_same_storage_rangecost(1,cnt) = fleet;
%     drone_fleet=fleet;
%     flight_paths
%     
%     diff_fleet_same_storage_avgcost(2,cnt) = sum(all_cost)/length(all_cost);
%     diff_fleet_same_storage_rangecost(2,cnt) = (max(all_cost)-min(all_cost));
%     
%     cnt = cnt+1
%     
% end

%run model with one storage location, one fleet size and different
%alpha/beta

% vary_gamma_drone1 = zeros(2,15);
% vary_gamma_drone2 = zeros(2,15);
% vary_gamma_drone3 = zeros(2,15);
% vary_gamma_drone4 = zeros(2,15);
% cost_min_per_gamma = zeros(2,15);
% cost_avg_per_gamma = zeros(2,15);
% cost_sdev_per_gamma = zeros(2,15);
% for gamma = [0.1:0.3:2.8]
%     
%     alpha = gamma/(gamma+1);
%     beta = (1-alpha);
%     
%     flight_paths
%     
%     vary_gamma_drone1(1,cnt) = gamma;
%     vary_gamma_drone2(1,cnt) = gamma;
%     vary_gamma_drone3(1,cnt) = gamma;
%     vary_gamma_drone4(1,cnt) = gamma;
%     
%     cost_min_per_gamma(1,cnt) = gamma;
%     cost_avg_per_gamma(1,cnt) = gamma;
%     cost_sdev_per_gamma(1,cnt) = gamma;
%     
%     ind_path_drones1 = zeros(1,length(optimal_plan_idx));
%     ind_path_drones2 = zeros(1,length(optimal_plan_idx));
%     path_drone1 = zeros(1,length(optimal_plan_idx));
%     path_drone2 = zeros(1,length(optimal_plan_idx));
%     path_drone3 = zeros(1,length(optimal_plan_idx));
%     path_drone4 = zeros(1,length(optimal_plan_idx));
%     for i=[1:length(optimal_plan_idx)]
%         [path,con,row] = get_path(optimal_plan_idx(i),drone_fleet^trips_all,size(all_cost));
%         ind_path_drone1(1,i) = sum(all_flight_drones(path,:,con)==0);
%         ind_path_drone2(1,i) = sum(all_flight_drones(path,:,con)==1);
%         
%         drone_fleet_config = mod(con,10);
%         
%         if configs(1,drone_fleet_config)==1
%             path_drone1(1,i)=path_drone1(1,i)+ind_path_drone1(1,i);
%         elseif configs(1,drone_fleet_config)==2
%             path_drone2(1,i)=path_drone2(1,i)+ind_path_drone1(1,i);
%         elseif configs(1,drone_fleet_config)==3
%             path_drone3(1,i)=path_drone3(1,i)+ind_path_drone1(1,i);
%         elseif configs(1,drone_fleet_config)==4
%             path_drone4(1,i)=path_drone4(1,i)+ind_path_drone1(1,i);
%         end
%         
%         if configs(2,drone_fleet_config)==1
%             path_drone1(1,i)=path_drone1(1,i)+ind_path_drone2(1,i);
%         elseif configs(2,drone_fleet_config)==2
%             path_drone2(1,i)=path_drone2(1,i)+ind_path_drone2(1,i);
%         elseif configs(2,drone_fleet_config)==3
%             path_drone3(1,i)=path_drone3(1,i)+ind_path_drone2(1,i);
%         elseif configs(2,drone_fleet_config)==4
%             path_drone4(1,i)=path_drone4(1,i)+ind_path_drone2(1,i);
%         end
%         
%         
%     end
%     
%     vary_gamma_drone1(2,cnt) = sum(path_drone1)/length(optimal_plan_idx);
%     vary_gamma_drone2(2,cnt) = sum(path_drone2)/length(optimal_plan_idx);
%     vary_gamma_drone3(2,cnt) = sum(path_drone3)/length(optimal_plan_idx);
%     vary_gamma_drone4(2,cnt) = sum(path_drone4)/length(optimal_plan_idx);
%     
% %     cost_min_per_gamma(2,cnt) = min(all_cost);
% %     cost_avg_per_gamma(2,cnt) = sum(all_cost)/length(all_cost);
% %     cost_sdev_per_gamma(2,cnt) = std(all_cost);
%     
%     cnt = cnt+1
%     
% end
%     
    
    
%run model with different trips_all and store the
%full cost function outputs

cost_output_by_trips = {0, 0, 0, 0};
for var = [7:10]
    trips_all = var;
    flight_paths
    
    %pull all the cost function outputs
    cost_output_by_trips{cnt} = all_cost;
    
    cnt = cnt+1
end
    
    

