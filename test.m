%Testing dial to call a number:
L = 80;
fs = 8000;
xx= dtmfdial(['1','2','3','4','D','9','*'],fs);
soundsc(xx,8000);
specgram(xx);
s = dtmfrun(xx,L,fs);
display(s);


