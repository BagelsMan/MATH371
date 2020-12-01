%plots all the hospital locations, color-coded by their medipack
%requirements
%create vectors for graphing purposes and graph
% figure;
hold on
all_hx = [];
all_hy = [];
for h=[1:hnum]
    all_hx = [all_hx all_h(h).x];
    all_hy = [all_hy all_h(h).y]; 
    if all_h(h).req==1
        scatter(all_h(h).x,all_h(h).y,'MarkerFaceColor','r','MarkerEdgeColor',[1 1 1])
    elseif all_h(h).req==2
        scatter(all_h(h).x,all_h(h).y,'MarkerFaceColor','b','MarkerEdgeColor',[1 1 1])
    elseif all_h(h).req==3
        scatter(all_h(h).x,all_h(h).y,'MarkerFaceColor','g','MarkerEdgeColor',[1 1 1])
    elseif all_h(h).req==5
        scatter(all_h(h).x,all_h(h).y,'MarkerFaceColor','m','MarkerEdgeColor',[1 1 1])
    end
end