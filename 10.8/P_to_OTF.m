function [OTF] = P_to_OTF(P)
H = P;
Hfft = fft2(H, size(H, 1), size(H, 2));
PSF = fftshift(Hfft);
PSF = abs(PSF).^2;

OTF = psf2otf(PSF);%PSF转化为OTF
% OTF = OTF/max(max(OTF));%光学传递函数OTF归一化
end

