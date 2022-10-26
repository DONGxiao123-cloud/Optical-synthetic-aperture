%-----------------------����ͼ������ϵ��----------------------------------

function [CC]=CorrelationCoefficient(imgA,imgB)
imgA=double(imgA);
imgB=double(imgB);

%---------------------------��׳���ж�--------------------------------------
[imgArow,imgAcol]=size(imgA);
[imgBrow,imgBcol]=size(imgB);
% [imgArow,imgAcol];
% [imgBrow,imgBcol];
if imgArow<1||imgAcol<1||imgBrow<1||imgBcol<1
    error('������������ά������С��1');
elseif imgArow~=imgBrow||imgAcol~=imgBcol
    error('������ľ���ά������ȣ�');
end

%------------------------������ͼ��ľ�ֵ��----------------------------------
imgA=imgA-mean2(imgA);
imgB=imgB-mean2(imgB);

%-----------------------������ͼ������ϵ��---------------------------------
CC=sum(sum(imgA.*imgB))./(sqrt(sum(sum(imgA.^2))).*sqrt(sum(sum(imgB.^2))));
 