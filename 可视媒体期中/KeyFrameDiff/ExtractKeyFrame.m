function  [keyindexde,realk]=ExtractKeyFrame(filename,k)
k=5;%ѡȡ�Ĺؼ�֡����kȡ2~10
filename='person01_boxing_d2_uncomp';%��ȡ��AVI�ļ���
AviFile=filename;
Mov=aviread(AviFile);%��ȡ�ļ�
AviInfo=aviinfo(AviFile);%��ȡAVI�ļ���Ϣ
FramesNum=AviInfo.NumFrames;%֡��
%simiraf=zeros(FramesNum);%����һ�������
%eulerdis=zeros(FramesNum);
eulerdisdiff=zeros(FramesNum);
meana=zeros(FramesNum);
varb=zeros(FramesNum);
diffc=zeros(FramesNum);
for i=1:FramesNum-2
%    simiraf(i)=SimilarRatioDiff(Mov,i);%������Ȼ�Ⱥ���
    eulerdisdiff(i)=EulerDistanceDiff(Mov,i);%����֡��ŷ�Ͼ��뺯��
end
for i=1:FramesNum-1
%    eulerdis(i)=EulerDistance(Mov,i);%����ŷ�Ͼ��뺯��
    meana(i)=FrameDiffMean(Mov,i);%����֡���ֵ����
    varb(i)=FrameDiffVar(Mov,i);%����֡����
    diffc(i)=sqrt(varb(i))/meana(i);%��֡��Ĳ���ϵ��
end
x=1:1:FramesNum-1;
x1=1:FramesNum-2;
%ysimiraf=simiraf';%ת��
%yeulerdis=eulerdis';
yeulerdisdiff=eulerdisdiff';%ת��
ymeana=meana';
yvarb=varb';
ydiffc=diffc';
%yysimiraf=ysimiraf(1,1:FramesNum-2);%ȡ����ĵ�1��
%yyeulerdis=yeulerdis(1,1:FramesNum-1);
yyeulerdisdiff=yeulerdisdiff(1,1:FramesNum-2);%ȡ����ĵ�1��
yymeana=ymeana(1,1:FramesNum-1);
yyvarb=yvarb(1,1:FramesNum-1);
yydiffc=ydiffc(1,1:FramesNum-1);
%figure;
%indexf=extremum(yysimiraf,x1);%���ü�ֵ��������֡����Ȼ�ȵļ�ֵ
figure;
indexde=extremum(yyeulerdisdiff,x1)%���ü�ֵ��������֡��ŷ�Ͼ���ļ�ֵ
yyde=yyeulerdisdiff(indexde);%��ֵ���Ӧ�ĺ���ֵ
maxyyde=max(yyde);%�����ֵ
minyyde=min(yyde);%����Сֵ
midyyde=(maxyyde+minyyde)/2;%���м�ֵ
selindexde=indexde(yyde>midyyde)%ȥ��С���м�ֵ�ļ�ֵ��
selyyde=yyeulerdisdiff(selindexde);
figure;
plot(x1,yyeulerdisdiff);
xlabel('x1'); ylabel('yyeulerdisdiff'); 
hold on; 
plot(selindexde,selyyde,'r+');%����ɸѡ�ļ�ֵ��
Len=length(selindexde);%����ɸѡ�ļ�ֵ��ĸ���
if k<=Len %ѡȡ�Ĺؼ�֡��С�ڵ���ɸѡ�ļ�ֵ��ĸ���
    keyindexde=selindexde(1:k) %ѡȡ��ǰk֡��Ϊ�ؼ�֡
    realk=k %ʵ��ѡȡ�ؼ�֡��
else
    keyindexde=selindexde(1:Len)
    realk=Len
end
keyyyde=yyeulerdisdiff(keyindexde);
%keymax=max(keyyyde)%���ú���ʵ��
%framenum=x1(keyyyde==keymax)
framenum=FrameNum(indexde,keyyyde)
figure;
plot(x1,yyeulerdisdiff);
xlabel('x1'); ylabel('yyeulerdisdiff'); 
hold on; 
plot(keyindexde,keyyyde,'r+');%�������յõ��Ĺؼ�֡
%figure;
%indexe=extremum(yyeulerdis,x)
figure;
indexa=extremum(yymeana,x)%���ü�ֵ��������֡���ֵ�ļ�ֵ
figure;
indexb=extremum(yyvarb,x)%���ü�ֵ��������֡���ļ�ֵ
figure;
indexc=extremum(yydiffc,x)%���ü�ֵ��������֡�����ϵ���ļ�ֵ
