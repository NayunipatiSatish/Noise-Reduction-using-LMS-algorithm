%noise cancellation

clear
close all

order=2;

size=2;                         %time duration of inputs
fs=8192;                                %digital sampling frequency
t=[0:1/fs:size];
N=fs*size;                      %size of inputs
f1=35/2;                                %frequency of voice
f2=99/2;                                %frequency of noise

voice=cos(2*pi*f1*t);
subplot(4,1,1)
plot(t,voice);
title('voice  ')

noise=sin(2*pi*f2*t.^2);                                %increasy frequency noise
primary=voice+noise;
subplot(4,1,2)
plot(t,noise)
title(' noise signal')
subplot(4,1,3)
plot(t,noise+voice)
title('primary = voice + noise ')
%ref=noise+.25*rand;                                             %noisy noise
%subplot(4,1,3)
%plot(t,ref)
%title('reference  (noisy noise)  ');

w=zeros(order,1);
mu=.006;
for i=1:N-order
   buffer = noise(i:i+order-1);                                   %current 32 points of reference
   desired(i) = primary(i)-buffer*w;                    %dot product reference and coeffs
   w=w+(buffer.*mu*desired(i)/norm(buffer))';%update coeffs
end

subplot(4,1,4)
plot(t(order+1:N),desired)
title('filtered signal')
