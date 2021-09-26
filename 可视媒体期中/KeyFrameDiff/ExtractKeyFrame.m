function  [keyindexde,realk]=ExtractKeyFrame(filename,k)
k=5;%选取的关键帧数，k取2~10
filename='person01_boxing_d2_uncomp';%读取的AVI文件名
AviFile=filename;
Mov=aviread(AviFile);%读取文件
AviInfo=aviinfo(AviFile);%读取AVI文件信息
FramesNum=AviInfo.NumFrames;%帧数
%simiraf=zeros(FramesNum);%产生一个零矩阵
%eulerdis=zeros(FramesNum);
eulerdisdiff=zeros(FramesNum);
meana=zeros(FramesNum);
varb=zeros(FramesNum);
diffc=zeros(FramesNum);
for i=1:FramesNum-2
%    simiraf(i)=SimilarRatioDiff(Mov,i);%调用似然比函数
    eulerdisdiff(i)=EulerDistanceDiff(Mov,i);%调用帧差欧氏距离函数
end
for i=1:FramesNum-1
%    eulerdis(i)=EulerDistance(Mov,i);%调用欧氏距离函数
    meana(i)=FrameDiffMean(Mov,i);%调用帧差均值函数
    varb(i)=FrameDiffVar(Mov,i);%调用帧差方差函数
    diffc(i)=sqrt(varb(i))/meana(i);%求帧差的差异系数
end
x=1:1:FramesNum-1;
x1=1:FramesNum-2;
%ysimiraf=simiraf';%转置
%yeulerdis=eulerdis';
yeulerdisdiff=eulerdisdiff';%转置
ymeana=meana';
yvarb=varb';
ydiffc=diffc';
%yysimiraf=ysimiraf(1,1:FramesNum-2);%取矩阵的第1行
%yyeulerdis=yeulerdis(1,1:FramesNum-1);
yyeulerdisdiff=yeulerdisdiff(1,1:FramesNum-2);%取矩阵的第1行
yymeana=ymeana(1,1:FramesNum-1);
yyvarb=yvarb(1,1:FramesNum-1);
yydiffc=ydiffc(1,1:FramesNum-1);
%figure;
%indexf=extremum(yysimiraf,x1);%调用极值函数，求帧差似然比的极值
figure;
indexde=extremum(yyeulerdisdiff,x1)%调用极值函数，求帧差欧氏距离的极值
yyde=yyeulerdisdiff(indexde);%求极值点对应的函数值
maxyyde=max(yyde);%求最大值
minyyde=min(yyde);%求最小值
midyyde=(maxyyde+minyyde)/2;%求中间值
selindexde=indexde(yyde>midyyde)%去掉小于中间值的极值点
selyyde=yyeulerdisdiff(selindexde);
figure;
plot(x1,yyeulerdisdiff);
xlabel('x1'); ylabel('yyeulerdisdiff'); 
hold on; 
plot(selindexde,selyyde,'r+');%经过筛选的极值点
Len=length(selindexde);%经过筛选的极值点的个数
if k<=Len %选取的关键帧数小于等于筛选的极值点的个数
    keyindexde=selindexde(1:k) %选取的前k帧作为关键帧
    realk=k %实际选取关键帧数
else
    keyindexde=selindexde(1:Len)
    realk=Len
end
keyyyde=yyeulerdisdiff(keyindexde);
%keymax=max(keyyyde)%不用函数实现
%framenum=x1(keyyyde==keymax)
framenum=FrameNum(indexde,keyyyde)
figure;
plot(x1,yyeulerdisdiff);
xlabel('x1'); ylabel('yyeulerdisdiff'); 
hold on; 
plot(keyindexde,keyyyde,'r+');%绘制最终得到的关键帧
%figure;
%indexe=extremum(yyeulerdis,x)
figure;
indexa=extremum(yymeana,x)%调用极值函数，求帧差均值的极值
figure;
indexb=extremum(yyvarb,x)%调用极值函数，求帧差方差的极值
figure;
indexc=extremum(yydiffc,x)%调用极值函数，求帧差差异系数的极值
