function b=FrameDiffVar(Mov,n) %«Û÷°≤Ó∑Ω≤Ó
Xn=rgb2gray(Mov(1,n).cdata);
Xn=double(Xn);
Xnp1=rgb2gray(Mov(1,n+1).cdata);
Xnp1=double(Xnp1);
b=var(Xnp1(:)-Xn(:));