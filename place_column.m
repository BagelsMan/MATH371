function [q] = place_column(area, d)
% area(row,column)
sz = size(area);
q = [0,0];
OK = 0;

for m=1:sz(1)
    for n=1:sz(2)
        if area(m,n) == 0 && d.w<sz(2)-n
            q = [m,n];
            for r=q(1):d.l+m
                OK=1;
                if area(r,q(2)) ~= 0
                    OK=0;
                    break;
                end
            end
            if OK==1
                for s=q(2):d.w+n
                    OK=1;
                    if area(q(1),s) ~= 0
                        OK=0;
                        break;
                    end
                end
            end
        end
        if OK==1
            break;
        end
    end
    if OK==1
        break;
    end
end

end

