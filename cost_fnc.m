function cost = cost_fnc(flight_plan, drone_cf, path_lines, drones, dronenum, space_left, alpha, beta)
%cost_fnc - the cost function for a given flight plan
%CURRENTLY IGNORES ROADS SURVEYED
%input:
%flight_plan - a row vector containing the hopsital location visisted at
%each time
%drone_cf - drone configuration: the drones that will be flying each path
%output:
%cost - a number to be optimized over

path_cost = zeros(1,length(flight_plan));

%compute total distance
dist_sq = (path_lines(1,1,:,1)-path_lines(1,1,:,3)).^2+(path_lines(1,1,:,2)-path_lines(1,1,:,4)).^2;
dist = squeeze(dist_sq(1,:,:)).^0.5;

%drone speed array/ drone capacity array
drone_sp = zeros(1,length(drone_cf));
drone_cap = zeros(1,length(drone_cf));
for d=[1:length(drone_cf)]
    drone_sp(d) = drones(drone_cf(d)+1).maxv;
    drone_cap(d) = drones(drone_cf(d)+1).packs;
end

%distance/max speed
norm_dist = dist./drone_sp';

%calculates all the packs delivered
packs_delivered = sum(drone_cap);

%calculates total cost
cost = alpha*packs_delivered/(sum(norm_dist))-beta*space_left/(1e5);





end

