%Testing dial to call a number:
xx= dtmfdial1(['1','2','3','4','5','6','7','8'],8000);
soundsc(xx,8000)
specgram(xx)