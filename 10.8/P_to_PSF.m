function [PSF] = P_to_PSF(P)
H = P;
Hfft = fft2(H, size(H, 1), size(H, 2));
PSF = fftshift(Hfft);
PSF = abs(PSF).^2;

% PSF = PSF/max(max(PSF));

end

