%run the model multiple times, changing alpha/beta

num_viable_paths = zeros(2,5);
%gamma = alpha/beta
cnt = 1;
for gamma = [1e5:2e5:1e6]
    beta = 0.00001;
    alpha = gamma*beta;
    
    flight_paths
    num = length(optimal_plan_idx);
    num_viable_paths(1,cnt) = gamma;
    num_viable_paths(2,cnt) = num;
    cnt = cnt+1
end