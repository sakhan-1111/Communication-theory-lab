% (ExampleQAMdemfilt.m)
% This program uses triangl.m and triplesinc.m
% to illustrate QAM modulation % and demodulation
% of two message signals.
clear;clf;
ts=1.e-4;
t=-0.04:ts:0.04;
Ta=0.01; fc=300;
% Use triangl.m and triplesinc.m to generate
% two message signals of different shapes and spectra
m_sig1=triangl((t+0.01)/0.01)-triangl((t-0.01)/0.01);
m_sig2=triplesinc(t,Ta);
Lm_sig=length(m_sig1)
Lfft=length(t); Lfft=2^ceil(log2(Lfft));
M1_fre=fftshift(fft(m_sig1,Lfft));
M2_fre=fftshift(fft(m_sig2,Lfft));
freqm=(-Lfft/2:Lfft/2-1)/(Lfft*ts);
%
B_m=150; %Bandwidth of the signal is B_m Hz.
% Design a simple lowpass filter with bandwidth B_m Hz.
h=fir1(40,[B_m*ts]);

% QAM signal generated by adding a carrier to DSB-SC
s_qam=m_sig1.*cos(2*pi*fc*t)+m_sig2.*sin(2*pi*fc*t);
Lfft=length(t); Lfft=2^ceil(log2(Lfft)+1);
S_qam=fftshift(fft(s_qam,Lfft));
freqs=(-Lfft/2:Lfft/2-1)/(Lfft*ts);

% Demodulation begins by using a rectifier
s_dem1=s_qam.*cos(2*pi*fc*t)*2;
S_dem1=fftshift(fft(s_dem1,Lfft));
% Demodulate the 2nd signal
s_dem2=s_qam.*sin(2*pi*fc*t)*2;
S_dem2=fftshift(fft(s_dem2,Lfft));
%
% Using an ideal LPF with bandwidth 150 Hz


s_rec1=filter(h,1,s_dem1);
S_rec1=fftshift(fft(s_rec1,Lfft));
s_rec2=filter(h,1,s_dem2);
S_rec2=fftshift(fft(s_rec2,Lfft));

Trange=[-0.025 0.025 -2 2];
Trange2=[-0.025 0.025 -2 4]
figure(1)
subplot(221);td1=plot(t,m_sig1);
axis(Trange); set(td1,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it m}({\it t})');
title('message signal 1')
subplot(222);td2=plot(t,s_qam);
axis(Trange); set(td2,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it s}_{\rm DSB}({\it t})');
title('QAM modulated signal');
subplot(223);td3=plot(t,s_dem1);
axis(Trange2); set(td3,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it x}({\it t})');
title('first demodulator output');
subplot(224);td4=plot(t,s_rec1);
axis(Trange); set(td4,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it m}_{d1}({\it t})');
title('detected signal 1');

figure(2)
subplot(221);td5=plot(t,m_sig2);
axis(Trange); set(td5,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it m}({it t})');
title('message signal 2');
subplot(222);td6=plot(t,s_qam);
axis(Trange); set(td6,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it s}_{\rm DSB}({it t})');
title('QAM modulated signal');
subplot(223);td7=plot(t,s_dem2);
axis(Trange2); set(td7,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it e}_1({it t})');
title('second demodulator output');
subplot(224);td8=plot(t,s_rec2);
axis(Trange2); set(td8,'Linewidth',1.5);
xlabel('{\it t} (sec)'); ylabel('{\it m}_{d2}({it t})');
title('detected signal 2');

Frange=[-700 700 0 250]
figure(3)
subplot(221);fd1=plot(freqm,abs(M1_fre));
axis(Frange); set(fd1,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it M}({it f})');
title('message 1 spectrum');
subplot(222);fd2=plot(freqs,abs(S_qam));
axis(Frange); set(fd2,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it S}_{rm AM}({\it f})');
title('QAM spectrum magnitude');
subplot(223);fd3=plot(freqs,abs(S_dem1));
axis(Frange); set(fd3,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it E}_1({\it f})');
title('first demodulator spectrum');
subplot(224);fd4=plot(freqs,abs(S_rec1));
axis(Frange); set(fd4,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it M}_{d1}({\it f})');
title('recovered spectrum 1');
figure(4)
subplot(221);fd1=plot(freqm,abs(M2_fre));
axis(Frange); set(fd1,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it M}({it f})');
title('message 2 spectrum');
subplot(222);fd2=plot(freqs,abs(S_qam));
axis(Frange); set(fd2,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it S}_{rm AM}({\it f})');
title('QAM spectrum magnitude');
subplot(223);fd7=plot(freqs,abs(S_dem2));
axis(Frange); set(fd7,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it E}_2({\it f})');
title('second demodulator spectrum');
subplot(224);fd8=plot(freqs,abs(S_rec2));
axis(Frange); set(fd8,'Linewidth',1.5);
xlabel('{\it f} (Hz)'); ylabel('{\it M}_{d2}({\it f})');
title('recovered spectrum 2');