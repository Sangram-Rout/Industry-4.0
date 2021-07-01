addpath('../data')
%%Data
[data,Fs] = audioread('XYtest.m4a');
data = resample(data,44100,Fs);
Fs = 44100;
% % figure
% % spectrogram(data,Fs/10,0,Fs/2,Fs)


seg = 0.1; %time segment length (seconds)
low_freq = 350;
x_num = 84/seg; % number of x movements

%%%%%preprocessing of X_data
input1 = zeros(low_freq,x_num);
output1 = zeros(x_num,1);
for i = 1:x_num
   i
   start = 4+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input1(:,i) = f(1:low_freq )/norm(f);
end

%%%%%preprocessing of Y_data
y_num = 84/seg; % number of x movements
input2 = zeros(low_freq,y_num);
output2 = ones(y_num,1);
for i = 1:y_num
   i
   start = 90+seg*(i-1);
   data_seg = data(int32((start)*Fs+1):int32((start+0.1)*Fs));
   f = abs(fft(data_seg));
   input2(:,i) = f(1:low_freq )/norm(f);
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
   input3(:,i) = f(1:low_freq )/norm(f);
end


%%%Compare Figure
figure
hold on
plot(10:10:3500,input1(:,200),'linewidth',1.6)
plot(10:10:3500,input1(:,500)+0.1*2,'linewidth',1.6)
plot(10:10:3500,input1(:,650)+0.2*2,'linewidth',1.6)
plot(10:10:3500,input2(:,200)+0.3*2,'linewidth',1.6)
plot(10:10:3500,input2(:,500)+0.4*2,'linewidth',1.6)
plot(10:10:3500,input2(:,650)+0.5*2,'linewidth',1.6)
plot(10:10:3500,input3(:,280)+0.6*2,'linewidth',1.6)
plot(10:10:3500,input3(:,700)+0.7*2,'linewidth',1.6)
plot(10:10:3500,input3(:,920)+0.8*2,'linewidth',1.6)
for i = 0.1:0.1:0.8
    x = [10,3500];
    y = [i,i]*2;
    plot(x,y,'--k');
end
set(gca,'fontsize',14)
xlabel('Freq(Hz)')

% preprocess of the data
input = [input1';input2';input3'];
output = [output1;output2;output3];

index = randperm(length(input));
train_index = index(1:length(input)*0.75);
test_index = index(length(input)*0.75+1:end);

train_input = input(train_index,:);
train_output = output(train_index,:);
test_input = input(test_index,:);
test_output = output(test_index,:);

save('data.mat','train_input','train_output','test_input','test_output')




