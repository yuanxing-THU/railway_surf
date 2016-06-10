data = load('AJGS-Guangzhou-Beijing-06062013-092518-1-(beg-1668).txt');
left_surf = data(1:400000,6)';
right_surf = data(1:400000,7)';

%%
Fs = 4;  % Sampling frequency
T = 1/Fs;   % Sampling period
N = 400000;             % Length of signal
t = (0:N-1)*T;        % Time vector

X = left_surf;
Y = fft(X);
Y = abs(Y/N);
Y = Y(1:N/2+1);
Y(2:end-1) = 2*Y(2:end-1); % single-sided spectrum

f = Fs*(0:(N/2))/N;
figure,plot(f,Y);
title('Single-Sided Amplitude Spectrum of surf within 100km in GB line');

%%

%切比雪夫滤波器 低通
[b1,a1]=cheby1(10,0.5,0.05);%计算滤波器系统函数分子分母多项式
M=512;
h=freqz(b1,a1,M);
ff=(0:1/M:1-1/M)*Fs/2;
figure,plot(ff,abs(h));grid;title('0~0.1Hz Chebyshev Type I filter');


%%
[b2,a2]=cheby1(5,0.5,[0.05,0.1],'bandpass');%计算滤波器系统函数分子分母多项式
M=512;
h=freqz(b2,a2,M);
ff=(0:1/M:1-1/M)*Fs/2;
figure,plot(ff,abs(h));grid;title('0.1~0.2Hz Chebyshev Type I filter');

%%
[b3,a3]=cheby1(5,0.5,[0.1,0.15],'bandpass');%计算滤波器系统函数分子分母多项式
M=512;
h=freqz(b3,a3,M);
ff=(0:1/M:1-1/M)*Fs/2;
figure,plot(ff,abs(h));grid;title('0.2~0.3Hz Chebyshev Type I filter');

%%
[b4,a4]=cheby1(5,0.5,[0.15,0.2],'bandpass');%计算滤波器系统函数分子分母多项式
M=512;
h=freqz(b4,a4,M);
ff=(0:1/M:1-1/M)*Fs/2;
figure,plot(ff,abs(h));grid;title('0.3~0.4Hz Chebyshev Type I filter');

%%

X1=filter(b1,a1,X);
Y1 = fft(X1);
Y1 = abs(Y1/N);
Y1 = Y1(1:N/2+1);
Y1(2:end-1) = 2*Y1(2:end-1);

X2=filter(b2,a2,X);
Y2 = fft(X2);
Y2 = abs(Y2/N);
Y2 = Y2(1:N/2+1);
Y2(2:end-1) = 2*Y2(2:end-1);

X3=filter(b3,a3,X);
Y3 = fft(X3);
Y3 = abs(Y3/N);
Y3 = Y3(1:N/2+1);
Y3(2:end-1) = 2*Y3(2:end-1);

X4=filter(b4,a4,X);
Y4 = fft(X4);
Y4 = abs(Y4/N);
Y4 = Y4(1:N/2+1);
Y4(2:end-1) = 2*Y4(2:end-1);

figure,
subplot(2,2,1);plot(f,Y1);
axis([0 2 0 0.15]);
subplot(2,2,2);plot(f,Y2);
axis([0 2 0 0.15]);
subplot(2,2,3);plot(f,Y3);
axis([0 2 0 0.15]);
subplot(2,2,4);plot(f,Y4);
axis([0 2 0 0.15]);


