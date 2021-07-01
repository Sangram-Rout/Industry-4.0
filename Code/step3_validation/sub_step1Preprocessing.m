addpath('../data')
%%Data
[data,Fs] = audioread('Triangle1.m4a');
data = resample(data,44100,Fs);
Fs = 44100;
% figure
% spectrogram(data,Fs/10,0,Fs/2,Fs)
seg = 0.1; %time segment length (seconds)
low_freq = 350;
%%%%%preprocessing of data1
num = 60/seg; % number of movements
input = zeros(low_freq,num);
for i = 1:num
   i
   start = 110+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input(:,i) = f(1:low_freq )/norm(f);
end
input = input';
save('data1.mat','input')

[data,Fs] = audioread('Triangle2.m4a');
data = resample(data,44100,Fs);
Fs = 44100;
% figure
% spectrogram(data,Fs/10,0,Fs/2,Fs)
seg = 0.1; %time segment length (seconds)
low_freq = 350;
%%%%%preprocessing of data1
num = 60/seg; % number of movements
input = zeros(low_freq,num);
for i = 1:num
   i
   start = 40+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input(:,i) = f(1:low_freq )/norm(f);
end
input = input';
save('data2.mat','input')



