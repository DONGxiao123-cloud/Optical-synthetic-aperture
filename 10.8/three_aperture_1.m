% three_aperture 三孔径阵列 每个孔径间隔 2/3 pi
% Rcirc 孔径半径
%x,y    位置坐标
function [PU] = three_aperture_1(Rcirc, x , y ,Rcirc1, x1 , y1  )

% 相邻孔径的相位差
delta = 2 * pi/3;

%% 三个内孔径
rho = sqrt(x*x+y*y);
theta = atan2(y,x);
pu0 = aperture(Rcirc, rho, theta);
pu1 = aperture(Rcirc, rho, theta + delta);
pu2 = aperture(Rcirc, rho, theta + 2 * delta);
%% 三个外子径
rho1 = sqrt(x1*x1+y1*y1);
theta1 = atan2(y1,x1);
pu3 = aperture(Rcirc1, rho1, theta1);
pu4 = aperture(Rcirc1, rho1, theta1 + delta);
pu5 = aperture(Rcirc1, rho1, theta1 + 2 * delta);
% 逻辑或 孔径阵列复合
pu = pu0 | pu1 | pu2 | pu3 | pu4 | pu5;

% 设置返回值
PU = double(pu);
end

