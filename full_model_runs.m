%run the model multiple times, changing alpha/beta

num_viable_paths = zeros(2,10);
%gamma = alpha/beta
for gamma = [1e5:2e5:2e6]
    beta = 0.00001;
    alpha = gamma*beta;
    
    flight_paths
    num_viable_paths = length(optimal_plan_idx);
end