% (triplesinc.m)
% Baseband signal for AM
% Usage m=triplesinc(t,Ta)
  function m=triplesinc(t,Ta)
 % t is the length of the signal
 % Ta is the parameter, equaling twice the delay
 %
 sig_1=sinc(2*t/Ta);
 sig_2=sinc(2*t/Ta-1);
 sig_3=sinc(2*t/Ta+1);
 m=2*sig_1+sig_2+sig_3;
 end