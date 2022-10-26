%-----------------------计算图像的相关系数----------------------------------

function [CC]=CorrelationCoefficient(imgA,imgB)
imgA=double(imgA);
imgB=double(imgB);

%---------------------------健壮性判断--------------------------------------
[imgArow,imgAcol]=size(imgA);
[imgBrow,imgBcol]=size(imgB);
% [imgArow,imgAcol];
% [imgBrow,imgBcol];
if imgArow<1||imgAcol<1||imgBrow<1||imgBcol<1
    error('您的输入有误！维数不能小于1');
elseif imgArow~=imgBrow||imgAcol~=imgBcol
    error('您输入的矩阵维数不相等！');
end

%------------------------求两幅图像的均值差----------------------------------
imgA=imgA-mean2(imgA);
imgB=imgB-mean2(imgB);

%-----------------------求两幅图像的相关系数---------------------------------
CC=sum(sum(imgA.*imgB))./(sqrt(sum(sum(imgA.^2))).*sqrt(sum(sum(imgB.^2))));
 