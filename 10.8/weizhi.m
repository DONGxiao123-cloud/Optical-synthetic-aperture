%% 给出内外圈构型的位置坐标
function [xx,yy,xxx,yyy,count,count01]=weizhi(delta_r,delta_r1,kmax,D,D0,x,y)
    count = 1;count1 = 0;count0=0;
    copyx=x;copyy=y;
    %% 用于计算内子径位置
    for i = 1:1:kmax
            delta_theta = mod((i),6);
            for j = 1:i
                x = x + delta_r*cos(delta_theta*pi/3);
                y = y + delta_r*sin(delta_theta*pi/3);
                xx(count)=x;
                yy(count)=y;
                count =count +1;
            end
    end

    %% 用于计算外子径初始位置坐标
    kmax1 = floor(2*D/(sqrt(3)*delta_r1));
   
    for i = 1:1:kmax1
        delta_theta = mod((i),6);
        for j = 1:i
            copyx = copyx + delta_r1*cos(delta_theta*pi/3);
            copyy = copyy + delta_r1*sin(delta_theta*pi/3);
        end
    end
   kmax2 = floor(2*D0/(sqrt(3)*delta_r1));
    x1=copyx;
    y1=copyy;
    %% 用于计算外子径位置
    for m =  1:kmax2
        delta_theta = mod((m),6);
        if m<=kmax1
            for n=1:m
                count0=count0+1;
                count1=count1+1;
            end
        else 
            for n = 1:m
                x1 = x1 + delta_r1*cos(delta_theta*pi/3);
                y1 = y1 + delta_r1*sin(delta_theta*pi/3);
                count1=count1+1;
                count01 = count1-count;
                xxx(count1-count0)=x1;
                yyy(count1-count0)=y1;
            end
        end
    end
end