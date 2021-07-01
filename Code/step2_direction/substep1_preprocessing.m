addpath('../data')
[data,Fs] = audioread('Direction.mp3');
figure
spectrogram(data,Fs/10,0,Fs/2,Fs,'yaxis')
t = 26.3; %start time
p = csvread('layer1.csv');
p = [44.680,49.652,40.73557;p]; %start point
figure
axis equal
hold on
plot(p(:,1),p(:,2))
grid on
xlabel('x (mm)')
ylabel('y (mm)')

seg = 560/360;
low_freq = 350;
output = [];
input = zeros(low_freq,360*10);
time = [];
for i = 1:360
    i
   start = 55.10+seg*(i-1);
   for j = 1:5
       dx = (p(i*5-3,1)-p(i*5-4,1));
       dy = (p(i*5-3,2)-bp(i*5-4,2));
       data_seg = data(int32((start+0.1*j)*Fs+1):int32((start+0.1*j+0.1)*Fs));
       time = [time;int32((start+0.1*j)*Fs+1)];
       f = abs(fft(data_seg));
       input(:,10*i-10+j) = f(1:low_freq)/norm(f);
       output = [output;max(abs(dx),abs(dy))/22.101];
   end
  for j = 1:5
       dx = (p(i*5-1,1)-p(i*5-2,1));
       dy = (p(i*5-1,2)-p(i*5-2,2));
       data_seg = data(int32((start+0.8+0.1*j)*Fs+1):int32((start+0.8+0.1*j+0.1)*Fs));
       time = [time;int32((start+0.8+0.1*j)*Fs+1)];
       f = abs(fft(data_seg));
       input(:,10*i-5+j) = f(1:low_freq)/norm(f);
       output = [output;max(abs(dx),abs(dy))/22.101];
   end
end

input = input';

index = randperm(length(input));
train_index = index(1:length(input)*0.75);
test_index = index(length(input)*0.75+1:end);

train_input = input(train_index,:);
train_output = output(train_index,:);
test_input = input(test_index,:);
test_output = output(test_index,:);

save('data.mat','train_input','train_output','test_input','test_output')




