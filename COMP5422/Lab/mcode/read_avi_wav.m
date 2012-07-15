clear;

%1.read audio
wav=wavread('Windows XP_wav.wav');%read
wavplay(wav);%play

%2. read video
avi = aviread('ellipse.avi');%read
figure(1),clf;
movie(avi);%play

