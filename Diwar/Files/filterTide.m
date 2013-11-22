function [ D ]= filterTide( A )

C=A';
range=length(C);
X = [1:range];
c = polyfit(X,C,3);
f = polyval(c,X);
D = C -f;