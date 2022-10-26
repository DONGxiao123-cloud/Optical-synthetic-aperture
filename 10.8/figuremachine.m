%% 对图像的处理
function [cc1,cc2,F_Output2,frest] = figuremachine(OTF,PSF,F_Input,I2)
[M,N]=size(I2);
Output = F_Input.*OTF;
F_Output = ifft2(Output,M,N);
F_Output1 = abs(F_Output);
F_Output2 = F_Output1';%转置将倒立图像扶正
F_Output2 = imrotate(F_Output2,90);%逆时针旋转90度
[cc1] = CorrelationCoefficient(I2,F_Output2);%退化图像与原始图像的相关系数
        
figure(2)
imshow(F_Output2);

%%维纳滤波复原（deconvwnr）
PSF = PSF/max(max(PSF));
frest=deconvwnr(F_Output1,PSF,0);
frest = abs(frest);
frest = frest';  
frest = imrotate(frest,90);
[cc2] = CorrelationCoefficient(I2,frest);%复原图像与原始图像的相关系数
end