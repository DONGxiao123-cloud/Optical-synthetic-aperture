% three_aperture ���׾����� ÿ���׾���� 2/3 pi
% Rcirc �׾��뾶
%x,y    λ������
function [PU] = three_aperture(Rcirc, x , y)

% ���ڿ׾�����λ��
delta = 2 * pi/3;
rho = sqrt(x*x+y*y);
theta = atan2(y,x);
% �����׾�
pu0 = aperture(Rcirc, rho, theta);
pu1 = aperture(Rcirc, rho, theta + delta);
pu2 = aperture(Rcirc, rho, theta + 2 * delta);

% �߼��� �׾����и���
pu = pu0 | pu1 | pu2;

% ���÷���ֵ
PU = double(pu);
end

