function [flight_plan,config,row] = get_path(idx,numconfig,sizecost)
%get_path gets the indices to index all_paths_lines and sorted_paths_drones
%   Takes linear index from the cost optimaztion rutine
[row, col] = ind2sub(sizecost, idx);
flight_plan = floor(col/numconfig)+1;
config = mod(col,numconfig)+1;

end
