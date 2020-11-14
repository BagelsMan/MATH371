%plot single flight path indexed by the number plot_path_num and a drone
%config specified by the numer dronecon
path_plot = all_paths_lines(ex_row,plot_path_num,:,:);
path_plot_mat = [path_plot(1,:,:,1); path_plot(1,:,:,2); path_plot(1,:,:,3); path_plot(1,:,:,4)];
figure;
hold on
plot_hosp
for pth=[1:length(path_plot_mat(1,:))]
    line_vec = path_plot_mat(:,pth);
    if all_flight_drones(plot_path_num,pth,dronecon)==1
        line([line_vec(1) line_vec(3)],[line_vec(2) line_vec(4)],'Color','r')
    elseif all_flight_drones(plot_path_num,pth,dronecon)==0
        line([line_vec(1) line_vec(3)],[line_vec(2) line_vec(4)],'Color','b')
    elseif all_flight_drones(plot_path_num,pth,dronecon)==2
        line([line_vec(1) line_vec(3)],[line_vec(2) line_vec(4)],'Color','g')
    end
    
end