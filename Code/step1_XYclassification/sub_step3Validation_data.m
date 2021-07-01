addpath('../data')
seg = 0.1; %time segment length (seconds)
low_freq = 350;

%%Data1
[data,Fs] = audioread('x.mp3');
figure
spectrogram(data,Fs/10,0,Fs/2,Fs)
num = 3/seg; % number of movements
%%%%%preprocessing
input1 = zeros(low_freq,num);
output1 = zeros(num,1);
for i = 1:num
   i
   start = 1.5+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input1(:,i) = f(1:low_freq )/norm(f);
end

%%Data2
[data,Fs] = audioread('y.mp3');
%figure
%spectrogram(data,Fs/10,0,Fs/2,Fs)

%%%%%preprocessing
num = 3/seg; % number of movements
input2 = zeros(low_freq,num);
output2 = ones(num,1);
for i = 1:num
   i
   start = 6+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input2(:,i) = f(1:low_freq )/norm(f);
end



%%%Compare Figure
figure
hold on
plot(input1(:,1))
plot(input1(:,5)+0.1)
plot(input1(:,10)+0.2)
plot(input2(:,1)+0.3)
plot(input2(:,5)+0.4)
plot(input2(:,10)+0.5)



% preprocess of the data
input = [input1';input2'];
output = [output1;output2];
save('vali_data.mat','input','output')




