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
d = 2.000001;%子径口径
r = d/2;
rho0 = 2*d;%初始中心距
phi0 = 0;%初始相位差
x = rho0*cos(phi0);
y = rho0*sin(phi0);%初始子径位置
D = 50;%目标等效口径
delta_r = d;%增长长度
%% 定义环形六子径
pu = golay6(r,x,y);
% imshow(pu);
psf = P_to_PSF(pu);
otf = P_to_OTF(pu);
mtf = P_to_MTF(pu);
count = 1;
% imshow(fftshift(otf));
%% 变阵
kmax=floor(2*D/(sqrt(3)*delta_r));
for i = 1:kmax
        delta_theta = mod((i),6);
        for j = 1:i
            x = x + delta_r*cos(delta_theta*pi/3);
            y = y + delta_r*sin(delta_theta*pi/3);
            pu1 = golay6(r,x,y);
            pu = pu + golay6(r,x,y);
            psf = psf + P_to_PSF(pu1);
            otf = otf + P_to_OTF(pu1);
            mtf = mtf + P_to_MTF(pu1);
            count =count + 1;
        end
end

PSF = psf;
OTF = otf;
MTF = mtf;
OTF = OTF/max(max(OTF));%光学传递函数OTF归一化
        
[cc1,cc2,F_Output2,frest] = figuremachine(OTF,PSF,F_Input,I2);% 处理图像
figure(2)
imshow(frest,[]);
title("恢复图像")
f = I2;
img = frest;
MSE=sum(sum(f-img).^2)/(M*N);
new_PSNR=20*log10(255/sqrt(MSE))