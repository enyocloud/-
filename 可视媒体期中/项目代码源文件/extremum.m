function  e=extremum(yy,x) %求极大值
Lmax = diff(sign(diff(yy)))== -2; % logic vector for the local max value 
% match the logic vector to the original vecor to have the same length 

%Lmax = [false; Lmax; false]; 
xmax = x (Lmax); % locations of the local max elements 
yymax = yy (Lmax); % values of the local max elements 

% plot them on a figure 
plot(x,yy); 
xlabel('x'); ylabel('yy'); 
hold on; 
plot(xmax, yymax, 'r+'); 
e=xmax;
hold off; 
