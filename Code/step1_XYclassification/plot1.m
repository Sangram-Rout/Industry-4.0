addpath('../data')
%%Data
[data,Fs] = audioread('XYtest.m4a');
data = resample(data,44100,Fs);
Fs = 44100;

seg = 1; %time segment length (seconds)
low_freq = 350;
x_num = 84/seg; % number of x movements
% % figure
% % spectrogram(data,Fs/10,0,Fs/2,Fs)
figure
start = 4;
data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
time = 0:0.1/length(data_seg):0.1-0.1/length(data_seg);
plot(time,data_seg,'-k','linewidth',1.5);
xlabel('time(s)')
ylabel('amp')
set(gca,'fontsize',16)

figure
f = abs(fft(data_seg));
f = f(1:low_freq )/norm(f);
freq = 10:10:low_freq*10;
plot(freq,f,'-k','linewidth',1.5);
xlabel('freq(Hz)')
ylabel('amp')
set(gca,'fontsize',16)


low_freq = 500;
%%%%%preprocessing of X_data
input1 = zeros(low_freq,x_num);
output1 = zeros(x_num,1);
for i = 1:x_num
   i
   start = 4+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+seg)*Fs));
   f = abs(fft(data_seg));
   input1(:,i) = f(1:low_freq )/norm(f(1:low_freq ));
end

%%%%%preprocessing of Y_data
y_num = 84/seg; % number of x movements
input2 = zeros(low_freq,y_num);
output2 = ones(y_num,1);
for i = 1:y_num
   i
   start = 90+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+seg)*Fs));
   f = abs(fft(data_seg));
   input2(:,i) = f(1:low_freq)/norm(f(1:low_freq ));
end

%%%%%preprocessing of XY_data
xy_num = 168/seg; % number of x movements
input3 = zeros(low_freq,xy_num);
output3 = 2*ones(xy_num,1);
for i = 1:xy_num
   i
   start = 180+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input3(:,i) = f(1:low_freq )/norm(f(1:low_freq ));
end




%%%Compare Figure
figure
hold on
plot(1:1:low_freq,input1(:,20),'linewidth',1.6)
plot(1:1:low_freq,input1(:,50)+0.1*2,'linewidth',1.6)
plot(1:1:low_freq,input1(:,65)+0.2*2,'linewidth',1.6)
plot(1:1:low_freq,input2(:,20)+0.3*2,'linewidth',1.6)
plot(1:1:low_freq,input2(:,50)+0.4*2,'linewidth',1.6)
plot(1:1:low_freq,input2(:,65)+0.5*2,'linewidth',1.6)
% plot(1:1:low_freq,input3(:,28)+0.8*2,'linewidth',1.6)
% plot(1:1:low_freq,input3(:,70)+0.9*2,'linewidth',1.6)
% plot(1:1:low_freq,input3(:,92)+1.0*2,'linewidth',1.6)
for i = 0.1:0.1:0.5
    x = [1,low_freq];
    y = [i,i]*2;
    plot(x,y,'--k');
end
legend('X-10','X-20','X-30','Y-10','Y-20','Y-30');
set(gca,'fontsize',14)
xlabel('Freq(Hz)')


load('loss_history.mat')
figure
plot(loss,'-k','linewidth',1.6)
grid on
set(gca,'fontsize',14)
xlabel('epoch')
ylabel('MSE loss')