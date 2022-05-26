function hh = dtmfdesign(fb, L, fs)
%DTMFDESIGN
% hh = dtmfdesign(fb, L, fs)
% returns a matrix (L by length(fb)) where each column contains
% the impulse response of a BPF, one for each frequency in fb
% fb = vector of center frequencies
% L = length of FIR bandpass filters
% fs = sampling freq
%
% Each BPF must be scaled so that its frequency response has a
% maximum magnitude equal to one.
n = 1:L-1;
ww = 0:pi/fs:pi;
hh = [];
for i = 1:length(fb)
    h = cos(2*pi*fb(i)*n/fs);
    beta = abs(1/max(freqz(h,1,ww)));
    h = beta*h;
    hh = [hh;h];
end 

end