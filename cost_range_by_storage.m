%find the max difference in the costs for each storage location
cost_range_by_loc = zeros(1,15);
for n=[1:15]
    costs = all_all_cost(n,:);
    range = max(costs)-min(costs);
    cost_range_by_loc(1,n) = range;
end