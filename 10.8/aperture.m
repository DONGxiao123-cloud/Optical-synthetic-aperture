function [PU] = aperture(Rcirc, rho, theta)
% aperture 做一个孔径 ------------------------------------
% Rcirc 孔径半径
% rho   距离中心距离
% theta 偏移角

% 排布图大小 M x M;
M = 512;
N = M;
% 空矩阵
pu = zeros(M);

% 圆域内赋值为 1
for n=1:N
    for m=1:M
        % 在图中心半径 Rcirc以内的点都置1 其余的都为0
        if(n-N/2)^2+(m-M/2)^2<Rcirc^2
            pu(n,m)=1;
        end
    end
end

% 平移坐标
x = round(rho*cos(theta));
y = round(rho*sin(theta));

% 平移
se = translate(strel(1), [x y]);%指定方向平移
pu = imdilate(pu,se);%%将灰度图膨胀
pu = transpose(pu);%转置
% 边角填充的 -inf 归零处理
P=find(pu<0);
pu(P(:))=0;
% 设置返回值
PU = pu;
end

