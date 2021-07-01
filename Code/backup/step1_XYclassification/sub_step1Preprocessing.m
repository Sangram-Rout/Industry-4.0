addpath('../data')
%%Data
[data,Fs] = audioread('XYtest.m4a');

figure
spectrogram(data,Fs/10,0,Fs/2,Fs)


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
plot(input1(:,200))
plot(input1(:,500)+0.1)
plot(input1(:,840)+0.2)
plot(input2(:,200)+0.3)
plot(input2(:,500)+0.4)
plot(input2(:,650)+0.5)
plot(input3(:,200)+0.7)
plot(input3(:,1000)+0.8)
plot(input3(:,1500)+0.9)


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




