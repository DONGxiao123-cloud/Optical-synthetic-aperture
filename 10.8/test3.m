%% 用于测试3+3构型的方案
%% 3是golay3构型，外面的3也是golay3构型
%% 内golay3构型从里到外 外Golay3从外到里
clear all;
clc;
%% 获取舰船原始图像
I = imread('舰船模型.jpg');
% I = imread('舰船模型2.jpg');
I1 = rgb2gray(I);%转化为灰度图
I2 = im2double(I1);%转化为double型
% figure(1);
% imshow(I2);%展示原始图像
% title('原始灰度图像');
Input = fliplr(I2);%矩阵左右翻转
Input = flipud(I2);%矩阵上下翻转
S_Input = double(Input);
[M,N]=size(I2);
F_Input = fft2(S_Input,M,N);%物方图像进行傅里叶变换 
F_abs = abs(F_Input);
F_shift = fftshift(F_abs);%将零频分量移到中心
%% 初始化各项参数
M = 512;
pu = zeros(M);
d = 2.001;%内子径口径
r = d/2;
d1 = 4.001;%外子径口径
r1 = d1/2;
rho0 = d;%初始中心距
rho1 = 22;
phi0 = 0;%初始相位差
phi01 = 0;
x = rho0*cos(phi0);
y = rho0*sin(phi0);%初始内子径位置
x1 = rho1*cos(phi01);
y1 = rho1*sin(phi01);%初始内子径位置
D0 = 50;%目标等效口径
D = 22;%内子径最大增长
delta_r = d;%内子径增长长度
delta_r1 = d1;%外子径增长长度
%% 定义golay3构型
pu= pu+three_aperture_1(r,x,y,r1,x1,y1);%初始阵列
%初始阵列的光学评价函数
psf = P_to_PSF(pu);
otf = P_to_OTF(pu);
mtf = P_to_MTF(pu);
% imshow(fftshift(otf));
%% 变阵
kmax=floor(2*D/(sqrt(3)*delta_r));
[xx,yy,xxx,yyy,count,count01]=weizhi(delta_r,delta_r1,kmax,D,D0,x,y);
countmin=min(count-1 ,count01-1);
for i = 1:1:countmin
        j = i;
        x = xx(j);
        y= yy(j);
        x1 = xxx(countmin-i+1);
        y1= yyy(countmin-i+1);
        pu1 = three_aperture_1(r,x,y,r1,x1,y1);
        pu = pu + three_aperture_1(r,x,y,r1,x1,y1);
        psf = psf + P_to_PSF(pu1);
        otf = otf + P_to_OTF(pu1);
        mtf = mtf + P_to_MTF(pu1);
end
imshow(pu);
PSF = psf;
OTF = otf;
MTF = mtf;
OTF = OTF/max(max(OTF));%光学传递函数OTF归一化
        
[cc1,cc2,F_Output2,frest] = figuremachine(OTF,PSF,F_Input,I2);% 处理图像
imshow(frest,[]);

f = I2;
img = frest;
MSE=sum(sum(f-img).^2)/(M*N);
new_PSNR=20*log10(255/sqrt(MSE))