% clear all;
% close all;
% clc;
% Req follows [A, B, C, D, E, F, G] order
% Req = [5,8,2,5,3,1,4]; %Req is just an integer array that has the numbers of each type of drone required to be packed
Req = pack_req;
Reqcopy = Req; %copy of Req (used later)
% Req = pack_req

%all the structs follow the format "l" length "w" width "h" height and are
%initialized in this order: container, drone A B C D E F G, medipack 1 2 3

c.l = 231;
c.w = 92;
c.h = 94;

A.l = 45;
A.w = 45;
A.h = 25;

B.l = 30;
B.w = 30;
B.h = 22;

C.l = 50;
C.w = 30;
C.h = 60;

D.l = 25;
D.w = 20;
D.h = 25;

E.l = 25;
E.w = 20;
E.h = 27;

F.l = 40;
F.w = 40;
F.h = 25;

G.l = 32;
G.w = 32;
G.h = 17;

%array of all drone structs used in loops
d = [A, B, C, D, E, F, G];

M1.l = 7;
M1.w = 5;
M1.h = 14;

M2.l = 5;
M2.w = 5;
M2.h = 8;

M3.l = 7;
M3.w = 4;
M3.h = 12;

%MAJOR SIMPLIFICATION #1: packing for medipacks is NOT CURRENTLY IMPLEMENTED
%MAJOR SIMPLIFICATION #2: the lxw of each column created is not 'fit' into
%the container area - currently I'm just subtracting the area of each column
%created from the total remaining container area. This must be changed

totA = 0;
col = repmat(struct('l',0,'w',0,'h',0), 50, 1); %creating an arbitrarily long enough array of empty structs (used later)

for p=1:100 %I couldn't quickly figure out a way to determine when no more drones can be fit in columns and no more columns can be fit in the area so I just have this outer loop run an arbitrary number of times so it will finish
    for i=1:length(Req) %looping through all drones
        if Req(i)>0 %if there are still drones of this type needed to be packed, then proceed
            for m=1:length(col) %start by trying to find a column that it will already fit in before deciding to make a new column
                if col(m).h ~= 0 %if the height is zero than column(m) hasn't been initialized yet so it's the end of the array
                    if d(i).l<col(i).l && d(i).w<col(i).w && d(i).h<col(m).h %if the drone package fits in l w h
                        Req(i)=Req(i)-1; % subtract one from requirements
%                         disp(Req(i));
                        col(m).h=col(m).h-d(i).h; % subtract the height of the package from the total height of the column
                    end
                end
            end
            if Req(i)>0 && d(i).l*d(i).w < c.l*c.w-totA % if there are still packages of this type left and none more can be fit into existing columns, create a new column if there is still enough square area remaining
                totA = totA+d(i).l*d(i).w; %add the area of this new column to the total area
                Req(i)=Req(i)-1; % subtract one from requirements
%                 disp(Req(i));
                for n=1:length(col)
                    if col(n).h == 0 %find the end of the columns array 
                        col(n).l = d(i).l; %initialize the length and width of the new column to equal that of the first package put in it, and the height as container height - package height
                        col(n).w = d(i).w;
                        col(n).h = col(n).h-d(i).h;
                    end
                end
            end
        end
    end
end

fulfilled = Reqcopy-Req; %how many packages were packed in by subtracting what's left in Req from a copy of the original Req
% disp(Req) %what's remaining (unfulfilled)
% disp(fulfilled) %what's fulfilled
% disp(c.l*c.w-totA) %how much square area is remaining
remaining = c.l*c.w-totA;





%extra code that doesn't matter 

% for m=1:100
%     for i=1:length(Req)
%         if Req(i)>0
%             if d(i).l*d(i).w < c.l*c.w-totA
%                 out(i)=out(i)+1;
%                 totA = totA+d(i).l*d(i).w;
%                 Req(i)=Req(i)-1;
%             end
%         end
%     end
% end

%for i=0: i<length(drns)
%    if drns(i).l*drns(i).w < totA
%        disp(drns
%        d.l = drns(i).l;
%        d.w = drns(i).w;
%        totA = totA-d.l*d.w;
%    end
%end
