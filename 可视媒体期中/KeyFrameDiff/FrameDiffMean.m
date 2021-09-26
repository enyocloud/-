function a=FrameDiffMean(Mov,n) %ÇóÖ¡²î¾ùÖµ
Xn=rgb2gray(Mov(1,n).cdata);
Xn=double(Xn);
Xnp1=rgb2gray(Mov(1,n+1).cdata);
Xnp1=double(Xnp1);
a=mean(Xnp1(:)-Xn(:));