%֡��ŷʽ���뷨��ȡ�ؼ�֡   ����ʵ��
clear all;
close all;
clc;
tic;
videoname = 'traffic.avi'; %��ȡ.avi��Ƶ�ļ�
Move = VideoReader(videoname);
FramesNum = Move.NumFrames;  %֡��
%****************��ȡ��Ƶ����ʾ֡��������ÿһ֡*******************
 for a = 1 : FramesNum% ��ȡ����
     strc = strcat(('.\frame'),'\',num2str(a),'.bmp');  %��Ƶ֡����ļ���
     frame = read(Move,a);
     imshow(frame);%��ʾ֡
     %imwrite(frame,strc,'bmp');% ����֡
end
%****************************************************************
vidHeight = Move.Height;
vidWidth = Move.Width;
%Preallocata movie structure*******************************
mov(1:FramesNum)=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
%������Źؼ�֡���ļ���
dirkeyf = ('.\Keyframe');%�����ȡ�Ĺؼ�֡��֡�Ű���Ƶ�е�˳��
mkdir(dirkeyf);  %�����ļ��д��ͼƬ
dkeylist=('.\keylist');%�����ȡ�Ĺؼ�֡��֡�Ű���Ȼ˳��
mkdir(dkeylist); %�����ļ��д��ͼƬ
%%
eulerdisdiff = zeros(FramesNum,1);  %ͼ���֡��ŷ�Ͼ���
diframe = ceil(FramesNum/120); %�����ȡ��
subframe = 1;
while subframe<diframe 
for k = 120*(subframe-1)+1:120*subframe
mov(k).cdata = readframe(Move,k);  %��ȡ��Ƶ�е�ÿһ֡ͼƬ
end
for i = 120*(subframe-1)+1:120*(subframe-1)+118
eulerdisdiff(i) = EulerDistanceDiff(mov,i);%����֡��ŷʽ���뺯��
end
x1=1:FramesNum-2;
yeulerdisdiff = eulerdisdiff';%ת��
yyeulerdisdiff = yeulerdisdiff(1,120*(subframe-1)+1:120*subframe-2);%ȡ����ĵ�һ��
indexde = extremum(yyeulerdisdiff,x1);%���ü�ֵ��������֡��ŷʽ����ļ�ֵ
yyde = yyeulerdisdiff(indexde);%��ֵ���Ӧ�ĺ���ֵ
maxyyde = max(yyde);%�����ֵ
minyyde = min(yyde);%����Сֵ
midyyde = (macyyde+minyyde)/2;%���м�ֵ
selindexde = indexde(yyde>midyyde);%ȥ��С���м�ֵ�ļ�ֵ��
realk = Len;
for j = 1:realk
indexset{subframe}(j) = keyindexde(j)+120*(subframe-1);
mov = readframe(Move,keyindexde(j)+120*(subframe-1));
%��avi��Ƶ��Ϣ����֡
strc = strcat(['.\Keyframe\'],'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');
%strc = strcat(dirkeyf,'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');%�༭ͼ�����ƣ�ʹ���ܴ����¼��ļ��У��Ҳ�����
imwrite(mov.cdata,strc,'bmp');%��ͼ����Ϣ�����ļ����Ա������������ʹ��
%imwrite(mov,strc,'bmp');
end
subframe = subframe+1;
end
for k = 120*(subframe-1)+1:FramesNum
mov(k).cdata = read(Move,k);
end
for i = 120*(subframe-1)+1:FramesNum-2
eulerdisdiff(i) = EulerDistanceDiff(mov,i);%����֡��ŷʽ���뺯��
end
x1 = 1:FramesNum-120*subframe + 118;
yeulerdisdiff = eulerdisdiff';%ת��
yyeulerdisdiff = yeulerdisdiff(1,120*(subframe-1)+1:FramesNum-2);%ȡ����ĵ�һ��
indexde = extremum(yyeulerdisdiff,x1);%���ü�ֵ��������֡��ŷʽ����ļ�ֵ
yyde = yyeulerdisdiff(indexde);%��ֵ���Ӧ�ĺ���ֵ
maxyyde = max(yyde);%
minyyde = min(yyde);%����Сֵ
midyyde = (maxyyde+minyyde)/2;
selindexde = indexde(yyde>midyyde);%ȥ��С���м�ֵ�ü�ֵ��
Len = numel(selindexde);%����ɸѡ�ļ�ֵ��ĸ���
keyindexde = selindexde(1:Len);%ѡȡɸѡ�������м�ֵ��
realk = Len;
for j = 1:realk
indexset{subframe}(j) = keyindexde(j)+120*(subframe-1);
n = keyindexde(j)+120*(subframe-1);
mov = read(Move,keyindexde(j)+120*(subframe-1));%��avi��Ƶ��Ϣ����֡
strc = strcat(dirkeyf,'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');%�༭ͼƬ���ƣ�ʹ���ܴ����¼��ļ��У��Ҳ�����
imwrite(mov,strc,'bmp');
end;
keyfnum = 0;
for i = 1:diframe
realknum = length(indexset{1,i});
for j = 1:realknum
keyfnum= keyfnum+1;
fname = strcat(dirkeyf,'\',int2str(indexset{i}(j)),'.bmp');
adata = imread(fname);
imwrite(adata,strcat(dkeylist,'\',num2str(keyfnum),'.bmp'),'bmp');
end
end
toc;