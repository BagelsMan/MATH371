function [med1, med2, med3] = medpacking(req,cargo,M1,M2,M3,CB1,CB2)
%standard: [len, wid, hei]
%% Cargo Box 1
if cargo == 1
    len=CB1(1);
    wid=CB1(2);
    hei=CB1(3);
    med1=0; 
    med2=0; 
    med3=0;
    
    while req(1)>0 || req(2)>0 || req(3)>0
        if req(1)>0
            if M1(1) < len %no rotations, M1 & CB1 are both in same config
                len=len-M1(1);
                wid=wid-M1(2);
                hei=hei-M1(3);
                med1=med1+1;
            elseif M1(1) < wid %rotate such that wid=len & len=wid
                len=len-M1(2);
                wid=wid-M1(1);
                hei=hei-M1(3);
                med1=med1+1;
            elseif M1(1) < hei %rotate such that len=hei
                len=len-M1(3);
                wid=wid-M1(2);
                hei=hei-M1(1);
                med1=med1+1;
            else
                req(1)=0;
            end
        end
        
        if req(2)>0
            if M2(1) < len %no rotations, M1 & CB1 are both in same config
                len=len-M2(1);
                wid=wid-M2(2);
                hei=hei-M2(3);
                med2=med2+1;
            elseif M2(1) < wid %rotate such that wid=len & len=wid
                len=len-M2(2);
                wid=wid-M2(1);
                hei=hei-M2(3);
                med2=med2+1;
            elseif M2(1) < hei %rotate such that len=hei
                len=len-M2(3);
                wid=wid-M2(2);
                hei=hei-M2(1);
                med2=med2+1;
            else
                req(2)=0;
            end
        end
        
        if req(3)>0
            if M3(1) < len %no rotations, M1 & CB1 are both in same config
                len=len-M3(1);
                wid=wid-M3(1);
                hei=hei-M3(1);
                med3=med3+1;
            elseif M3(1) < wid %rotate such that wid=len & len=wid
                len=len-M3(2);
                wid=wid-M3(1);
                hei=hei-M3(3);
                med3=med3+1;
            elseif M3(1) < hei %rotate such that len=hei
                len=len-M3(3);
                wid=wid-M3(2);
                hei=hei-M3(1);
                med3=med3+1;
            else
                req(3)=0;
            end
        end   
    end
end  
%% Cargo Box 2
if cargo == 2
    len=CB2(1);
    wid=CB2(2);
    hei=CB2(3);
    med1=0; 
    med2=0; 
    med3=0;
    
    while req(1)>0 || req(2)>0 || req(3)>0
        if req(1)>0
            if M1(1) < CB2(1) %no rotations, M1 & CB1 are both in same config
                len=len-M1(1);
                wid=wid-M1(1);
                hei=hei-M1(1);
                med1=med1+1;
            elseif M1(1) < CB2(2) %rotate such that wid=len & len=wid
                len=len-M1(2);
                wid=wid-M1(1);
                hei=hei-M1(3);
                med1=med1+1;
            elseif M1(1) < CB2(3) %rotate such that len=hei
                len=len-M1(2);
                wid=wid-M1(3);
                hei=hei-M1(1);
                med1=med1+1;
            else
                req(1)=0;
            end
        end
        
        if req(2)>0
            if M2(1) < CB2(1) %no rotations, M1 & CB1 are both in same config
                len=len-M2(1);
                wid=wid-M2(1);
                hei=hei-M2(1);
                med2=med2+1;
            elseif M2(1) < CB2(2) %rotate such that wid=len & len=wid
                len=len-M2(2);
                wid=wid-M2(1);
                hei=hei-M2(3);
                med2=med2+1;
            elseif M2(1) < CB2(3) %rotate such that len=hei
                len=len-M2(2);
                wid=wid-M2(3);
                hei=hei-M2(1);
                med2=med2+1;
            else
                req(2)=0;
            end
        end
        
        if req(3)>0
            if M3(1) < CB2(1) %no rotations, M1 & CB1 are both in same config
                len=len-M3(1);
                wid=wid-M3(1);
                hei=hei-M3(1);
                med3=med3+1;
            elseif M3(1) < CB2(2) %rotate such that wid=len & len=wid
                len=len-M3(2);
                wid=wid-M3(1);
                hei=hei-M3(3);
                med3=med3+1;
            elseif M3(1) < CB2(3) %rotate such that len=hei
                len=len-M3(2);
                wid=wid-M3(3);
                hei=hei-M3(1);
                med3=med3+1;
            else
                req(3)=0;
            end
        end   
    end
end
end

