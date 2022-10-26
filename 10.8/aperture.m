function [PU] = aperture(Rcirc, rho, theta)
% aperture ��һ���׾� ------------------------------------
% Rcirc �׾��뾶
% rho   �������ľ���
% theta ƫ�ƽ�

% �Ų�ͼ��С M x M;
M = 512;
N = M;
% �վ���
pu = zeros(M);

% Բ���ڸ�ֵΪ 1
for n=1:N
    for m=1:M
        % ��ͼ���İ뾶 Rcirc���ڵĵ㶼��1 ����Ķ�Ϊ0
        if(n-N/2)^2+(m-M/2)^2<Rcirc^2
            pu(n,m)=1;
        end
    end
end

% ƽ������
x = round(rho*cos(theta));
y = round(rho*sin(theta));

% ƽ��
se = translate(strel(1), [x y]);%ָ������ƽ��
pu = imdilate(pu,se);%%���Ҷ�ͼ����
pu = transpose(pu);%ת��
% �߽����� -inf ���㴦��
P=find(pu<0);
pu(P(:))=0;
% ���÷���ֵ
PU = pu;
end

