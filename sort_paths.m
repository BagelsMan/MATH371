% sort through and analyze flight paths
sorted_paths = [];
sorted_paths_drones = [];
for path_num=[1:length(all_flight_paths(:,1))]
    path = all_flight_paths(path_num,:);
    drones = all_flight_drones(path_num,:,:);
    flag = true;
    %check if each hospital is reached once
    for h=[1:hnum]
        if ismember(h-1,path)==0
            flag = false;
        end
    end
    htots = zeros(1,hnum);
    for fnum=[1:length(path)]
        htots(path(fnum)+1)=htots(path(fnum)+1)+1;
    end
    for hosp=[1:hnum]
        if htots(hosp)<all_h(hosp).req
            flag=false;
        end
    end
    %check drone configurations with packing algorithm
    for arra=[1:length(drones(1,1,:))]
        drone_arrangement = drones(1,:,arra);
        drone_types = max(drone_arrangement)-min(drone_arrangement)+1;
        pack_req = zeros(1,drone_types);
        for t = [1:drone_types]
            pack_req(t) = sum(drone_arrangement == (t-1));
        end
        %make pack_req the right size
        while (length(pack_req)<7)
            pack_req = [pack_req 0];
        end
        cont_packing
        if sum(Req ~= 0)>0
            flag==false;
        end
    end
    
    if flag==true
        sorted_paths=[sorted_paths; path];
        sorted_paths_drones=[sorted_paths_drones; drones];
    end
end
