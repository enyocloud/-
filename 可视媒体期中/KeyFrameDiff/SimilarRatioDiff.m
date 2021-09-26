function f=SimilarRatioDiff(Mov,n) %求帧间似然比
Xn=rgb2gray(Mov(1,n).cdata);
Xn=double(Xn);
Xnp1=rgb2gray(Mov(1,n+1).cdata);
Xnp1=double(Xnp1);
Xnq1=rgb2gray(Mov(1,n+2).cdata);
Xnq1=double(Xnq1);
f=((std(Xnp1(:)-Xn(:))+std(Xnq1(:)-Xnp1(:)))/2+((mean(Xnp1(:)-Xn(:))-mean(Xnq1(:)-Xnp1(:)))/2)^2)^2;