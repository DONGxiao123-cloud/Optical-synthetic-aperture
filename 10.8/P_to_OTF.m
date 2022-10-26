function [OTF] = P_to_OTF(P)
H = P;
Hfft = fft2(H, size(H, 1), size(H, 2));
PSF = fftshift(Hfft);
PSF = abs(PSF).^2;

OTF = psf2otf(PSF);%PSFת��ΪOTF
% OTF = OTF/max(max(OTF));%��ѧ���ݺ���OTF��һ��
end

