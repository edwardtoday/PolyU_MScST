clc;
clear all;
close all;
figure;
x=[33 45  51 57 60 69 72 81 87 90];
y=[125 123 120 119 118 116 115 113 111 110];
plot(x,y,'rv');
line(x,y);
title('Performance Improvement Graph: No of neurons in hidden layer Vs Execution Time');
xlabel('No of Neurons')
ylabel('TIME in seconds')
axis([10 100 100 125])
grid on
figure;
x=[2 4 6 8 10 12 14 16 18 20 22 24 26 28 30];
y1=[100 100 100 98 97 95 94 93 90 88 86 86 85 83 82];
y2=[100 100 100 95 94 93 90 89 87 86 85 84 83 82 80];
uu=plot(x,y1,'b-*');
%line(x,y1);
hold on
xx=plot(x,y2,'r-v');
%line(x,y2');
title('Performance comparison of BPN and PCA');
xlabel('No of Subjects')
ylabel('Percentage of Recognition')
axis([1 35 0 110])
grid on
legend([uu,xx],'BPN','PCA');


