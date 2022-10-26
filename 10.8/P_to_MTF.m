function [MTF] = P_to_MTF(P)
H = P;
Hfft = fft2(H, size(H, 1), size(H, 2));
PSF = fftshift(Hfft);
PSF = abs(PSF).^2;

OTF = psf2otf(PSF);%PSF×ª»¯ÎªOTF
MTF = fftshift(OTF);
MTF = abs(MTF);

% MTF = MTF / max(max(MTF));
end

