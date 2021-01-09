x = 22;

[sig, freq, tm] = rdsamp('baza/S002/S002R01.edf', x); %preberemo posnetek

high =0.1;
low = 30;
threshold = 70;
N = 4;

% butterworth filter
[b, a] = butter(4, [high low] / (freq/2), 'bandpass');
sig = filtfilt(b, a, sig); %filtriranje


figure(1);
plot(tm, sig)
title('Pred odstranjevanjem artefaktov');
ylim([-500 500])

%odstranjevanje artefaktov
for i = 1 : length(sig)
    if abs(sig(i)) > threshold
        sig(i) = 0;
        for j = 1 : (N/2)
           sig(i-j) = 0;
           sig(i+j) = 0;
        end
    end
end


figure(2);
plot(tm, sig)
title('Po odstranjevanju artefaktov');
ylim([-500 500])
