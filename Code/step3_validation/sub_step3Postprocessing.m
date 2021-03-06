load('Result1.mat')


dir = a/10;
figure 
plot(0:0.1:59.9,acos(dir)/pi*180,'linewidth',1.5)
xlabel('time (s)')
ylabel('angle (degree)')


X = [2];
Y = [5];
for i = 1:34
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 35:69
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 70:103
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 104:138
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 139:173
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 174:207
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 208:242
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 243:276
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
figure
plot(X,Y)
axis equal
hold on
plot(c(:,1)-c(1,1),c(:,2)-c(1,2),'linewidth',1.5)
legend('predicted','ideal')
xlabel('x(mm)')
ylabel('y(mm)')
set(gca,'fontsize',16)



X = [2];
Y = [5];
for i = 1:length(b);
    if dir(i)>0.95 && b(i) == 0
        dir(i) = 1;
    end
end
for i = 1:34
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 35:69
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 70:103
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 104:138
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 139:173
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 174:207
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 208:242
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 243:276
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
figure
plot(X,Y)
axis equal
hold on
plot(c(:,1)-c(1,1),c(:,2)-c(1,2),'linewidth',1.5)
legend('predicted','ideal')
xlabel('x(mm)')
ylabel('y(mm)')
set(gca,'fontsize',16)
