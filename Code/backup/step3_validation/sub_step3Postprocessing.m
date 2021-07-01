dir = a/10;
X = [0];
Y = [0];
for i = 1:35
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 36:70
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 71:105
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 106:140
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 141:175
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 176:210
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
for i = 211:245
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)+dir(i)*3];
end
for i = 246:280
    X = [X;X(i)+sqrt(1-(dir(i))^2)*3];
    Y = [Y;Y(i)-dir(i)*3];
end
for i = 281:315
    X = [X;X(i)-dir(i)*3];
    Y = [Y;Y(i)-sqrt(1-(dir(i))^2)*3];
end
plot(X,Y)
axis equal