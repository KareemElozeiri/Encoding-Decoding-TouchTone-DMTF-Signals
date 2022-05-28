function xx = dtmfdial(keyNames,fs)
%DTMFDIAL Create a signal vector of tones which will dial
% a DTMF (Touch Tone) telephone system.
%
% usage: xx = dtmfdial(keyNames,fs)
% keyNames = vector of characters containing valid key names
% fs = sampling frequency
% xx = signal vector that is the concatenation of DTMF tones.
%
dtmf.keys = ...
['1','2','3','A';
'4','5','6','B';
'7','8','9','C';
'*','0','#','D'];
dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);

%tone_dur=0.20;
tone_dur=0.20;
sil_dur=0.05;

tt= 0:1/fs:tone_dur;
xx=0;
for i= 1:length(keyNames)
    k = keyNames(i); %store each of the keynames at a time...

    [irow,jcol] = find(dtmf.keys == k); %find the indices where the keyname is at.

    if (numel(irow)==0 | numel(jcol)==0)
        disp("Invalid key!");
        %error("Invalid key!");
        continue
    end

    tone = cos(2*pi*dtmf.rowTones(irow,jcol)*tt) + cos(2*pi*dtmf.colTones(irow,jcol)*tt); %tone as the sum of the 2 frequencies comps.

    %xx=[xx, tone]; %concatenation
    %Silence needs to be added...
    %xx= [xx, 0,tone]; %No duration!
    xx=[xx, zeros(1, fs*sil_dur), tone];
end