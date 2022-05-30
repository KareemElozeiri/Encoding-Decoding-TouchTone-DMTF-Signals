function keys = dtmfrun(xx,L,fs)

%DTMFRUN keys = dtmfrun(xx,L,fs)
% returns the list of key names found in xx.
% keys = array of characters, i.e., the decoded key names
% xx = DTMF waveform
% L = filter length
% fs = sampling freq

dtmf.keys = ... 
   ['1','2','3','A';
    '4','5','6','B';
    '7','8','9','C';
    '*','0','#','D'];

dtmf.colTones = ones(4,1)*[1209,1336,1477,1633];
dtmf.rowTones = [697;770;852;941]*ones(1,4);


center_freqs = [dtmf.rowTones(:,1)' , dtmf.colTones(1,:)]; 

% hh = L by 8 MATRIX of all the filters. Each column contains the
% impulse response of one BPF
hh = dtmfdesign(center_freqs, L, fs);

% find the beginning and end of tone bursts
[nstart,nstop] = dtmfcut(xx,fs);

keys = []; 
locs = []; 
for kk=1:length(nstart) 
    x_seg = xx(nstart(kk):nstop(kk));
    locs = []; 

    for jj=1:length(center_freqs) 
        
        locs = [locs, dtmfscore(x_seg,hh(:,jj))];
    end
     
    aa = find(locs == 1)
    
    if length(aa) ~= 2 | aa(1) > 4 | aa(2) < 5
        
        continue
    end

    row = aa(1);
    col = aa(2)-4;

    keys = [keys, dtmf.keys(row,col)];
end