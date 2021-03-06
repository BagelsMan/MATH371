% Optimizes flight paths


close all

%% initialize hospitals
hnum = 3;   %number of hospitals
%lon - x
%lat - y

h1.x = 18.33;   %x coordinate
h1.y = -65.65;   %y coordinate
h1.req = 2;     %number of medipacks required

h2.x = 18.22;   %x coordinate
h2.y = -66.03;   %y coordinate
h2.req = 3;     %number of medipacks required

h3.x = 18.44;   %x coordinate
h3.y = -66.07;   %y coordinate
h3.req = 2;     %number of medipacks required

h4.x = 18.40;   %x coordinate
h4.y = -66.16;   %y coordinate
h4.req = 5;     %number of medipacks required

h5.x = 18.47;    %x coordinate
h5.y = -66.73;  %y coordinate
h5.req = 1;     %number of medipacks required

all_h = [h1 h2 h3];

%% initialize drones
dronenum = 4;   %number of different drone choices
latperkm = 0.00898;

drone1.packs = 1;    %number of packs drone is capable of holding at a time
drone1.radius = 0.01;  %radius with which the drone can survey roads it passes
drone1.maxv = 40*latperkm;   %max drone speed

drone2.packs = 1;    %number of packs drone is capable of holding at a time
drone2.radius = 0.01;  %radius with which the drone can survey roads it passes
drone2.maxv = 79*latperkm;   %max drone speed

drone3.packs = 2;    %number of packs drone is capable of holding at a time
drone3.radius = 0.01;  %radius with which the drone can survey roads it passes
drone3.maxv = 64*latperkm;   %max drone speed

drone4.packs = 1;    %number of packs drone is capable of holding at a time
drone4.radius = 0.01;  %radius with which the drone can survey roads it passes
drone4.maxv = 60*latperkm;   %max drone speed

drone5.packs = 2;    %number of packs drone is capable of holding at a time
drone5.radius = 0.01;  %radius with which the drone can survey roads it passes
drone5.maxv = 60*latperkm;   %max drone speed

drone6.packs = 2;    %number of packs drone is capable of holding at a time
drone6.radius = 0.01;  %radius with which the drone can survey roads it passes
drone6.maxv = 79*latperkm;   %max drone speed

drone7.packs = 2;    %number of packs drone is capable of holding at a time
drone7.radius = 0.01;  %radius with which the drone can survey roads it passes
drone7.maxv = 64*latperkm;   %max drone speed

all_drone = [drone4 drone5 drone6 drone7];

%% starting locations

% calls starting locations from spreadsheet
storagelocations = readtable('storage_locations2.xlsx');

% sets starting locations (currently set in loop to test list of locations
 startx = 0;
 starty = 0;

 %% Cost function parameters
 alph = 1;
 beta = 0.5;
 
%% Plots hospital locations colored by medipack
figure;
plot_hosp
xlim([0 20])
ylim([0 20])

%% generate possible flight paths

% each flight path is a vector of 2D lines, each represented as a pair of
% points in 2D space
% each 2D line is a path of a certain drone to a certain hospital
drone_fleet = 2;    %number of drones in the fleet simulated

%number of drone configurations
n = dronenum;
r = drone_fleet;
config_num = nchoosek(n+r-1,r);
configs = [1 1 1 1 2 2 2 3 3 4; 1 2 3 4 2 3 4 3 4 4];
%number of allowed trips
% trips_all = 7;
%creates all flight paths
% for drone_config = [1:config_num]
%     for drone = [1:drone_fleet]
%         for hosp = [1:hnum]
%             flight_path = zeros(1,trips_all);
%             flight_path(1) = [drone,[startx,starty],[h_all(hosp).x,h_all(hosp).y]];
%             for other_hosp = [1:(hnum-1)]
%                 mod(hosp,drone) because you will have 'drone' number of
%                 selections for the drone
%                 flight_path(other_hosp+1)=[mod(hosp,drone),
%             end
%         end
%     end
% end

%create raw number flight paths
all_flight_paths = [];
all_flight_drones = [];
disp(hnum^(trips_all))
for paths = [1:hnum^(trips_all)]
    base_t_num = num2cell(dec2base(paths-1,hnum));
    flight_path = zeros(1,length(base_t_num));
    for val=[1:(length(base_t_num))]
        flight_path(val)=str2double(base_t_num(length(base_t_num)-(val-1)));
    end

    while length(flight_path)<trips_all
        flight_path = [0 flight_path];
    end
    %account for different drone types
    drones = zeros(1,trips_all,drone_fleet^trips_all);
    for flight=[1:drone_fleet^trips_all]
        base_t_num2 = num2cell(dec2base(flight-1,drone_fleet));
        drone_sp = zeros(1,length(base_t_num2));
        for val=[1:(length(base_t_num2))]
            drone_sp(val)=str2double(base_t_num2(length(base_t_num2)-(val-1)));
        end
        drone_sp;
        while length(drone_sp)<trips_all
            drone_sp = [0 drone_sp];
        end
        drones(:,:,flight) = drone_sp;
    end
    all_flight_drones = [all_flight_drones; drones];

    all_flight_paths = [all_flight_paths; flight_path];
    disp(paths)
end
%create more meaningful representations of the flight paths (with 2D lines)

% all_paths_lines = int16.empty(sz(1),sz(2),4)
% for path_num=[1:length(all_flight_paths)]
%     path = all_flight_paths(path_num,:);
%     for trip=[1:length(path)]
%         all_paths_lines(path_num,trip,:) = [startx,starty,all_h(path(trip)+1).x,all_h(path(trip)+1).y];
%     end
% end

%sort the paths to get rid of ones that don't fill requirements
sort_paths
disp('paths sorted...')

sz = size(sorted_paths);
all_paths_lines = zeros(1,sz(1),sz(2),4);

% for i = 1:15
% i=1;
location = 1;
startx = storagelocations{location,7};
starty = storagelocations{location,8};

for path_num=[1:length(sorted_paths)]
    path = sorted_paths(path_num,:);
    path_num;
    for trip=[1:length(path)]
        all_paths_lines(1,path_num,trip,:) = [startx,starty,all_h(path(trip)+1).x,all_h(path(trip)+1).y];
    end
end
% end

disp('lines created...')
 
%% optimizes all flight paths to minimize cost function
% all_all_cost = [];

% for i = 1:15
i=1;
location = 1;
all_cost = [];
    for path=[1:length(sorted_paths)]
        for config=[1:length(sorted_paths_drones(1,1,:))]
                all_cost= [all_cost cost_fnc(sorted_paths(path,:), sorted_paths_drones(path,:,config), all_paths_lines(i,path,:,:), all_drone, dronenum, space_remaining(path), alph, beta)];
        end
    end
%     all_all_cost(i,:) = all_cost;
% end


% pulls minimum cost flight plans
% optimal_plan_idx = find(all_all_cost==min(all_all_cost,[], 'all'));
optimal_plan_idx = find(all_cost==min(all_cost));
% cost_by_supply = sum(all_all_cost');

disp(['Found ' num2str(length(optimal_plan_idx)) ' optimal flight plans'])

% [ex_path,ex_con, ex_row] = get_path(optimal_plan_idx(1),drone_fleet^trips_all, size(all_all_cost));
[ex_path,ex_con, ex_row] = get_path(optimal_plan_idx(1),drone_fleet^trips_all, size(all_cost));
dronecon = ex_con;
plot_path_num = ex_path;
plot_path;



