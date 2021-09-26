%帧差欧式距离法提取关键帧   可以实现
clear all;
close all;
clc;
tic;
videoname = 'traffic.avi'; %读取.avi视频文件
Move = VideoReader(videoname);
FramesNum = Move.NumFrames;  %帧数
%****************读取视频，显示帧，并保存每一帧*******************
 for a = 1 : FramesNum% 读取数据
     strc = strcat(('.\frame'),'\',num2str(a),'.bmp');  %视频帧存放文件夹
     frame = read(Move,a);
     imshow(frame);%显示帧
     %imwrite(frame,strc,'bmp');% 保存帧
end
%****************************************************************
vidHeight = Move.Height;
vidWidth = Move.Width;
%Preallocata movie structure*******************************
mov(1:FramesNum)=struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);
%建立存放关键帧的文件夹
dirkeyf = ('.\Keyframe');%存放提取的关键帧，帧号按视频中的顺序
mkdir(dirkeyf);  %创建文件夹存放图片
dkeylist=('.\keylist');%存放提取的关键帧，帧号按自然顺序
mkdir(dkeylist); %创建文件夹存放图片
%%
eulerdisdiff = zeros(FramesNum,1);  %图像的帧差欧氏距离
diframe = ceil(FramesNum/120); %无穷大取整
subframe = 1;
while subframe<diframe 
for k = 120*(subframe-1)+1:120*subframe
mov(k).cdata = readframe(Move,k);  %读取视频中的每一帧图片
end
for i = 120*(subframe-1)+1:120*(subframe-1)+118
eulerdisdiff(i) = EulerDistanceDiff(mov,i);%调用帧差欧式距离函数
end
x1=1:FramesNum-2;
yeulerdisdiff = eulerdisdiff';%转置
yyeulerdisdiff = yeulerdisdiff(1,120*(subframe-1)+1:120*subframe-2);%取矩阵的第一行
indexde = extremum(yyeulerdisdiff,x1);%调用极值函数，求帧差欧式距离的极值
yyde = yyeulerdisdiff(indexde);%求极值点对应的函数值
maxyyde = max(yyde);%求最大值
minyyde = min(yyde);%求最小值
midyyde = (macyyde+minyyde)/2;%求中间值
selindexde = indexde(yyde>midyyde);%去掉小于中间值的极值点
realk = Len;
for j = 1:realk
indexset{subframe}(j) = keyindexde(j)+120*(subframe-1);
mov = readframe(Move,keyindexde(j)+120*(subframe-1));
%将avi视频信息读入帧
strc = strcat(['.\Keyframe\'],'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');
%strc = strcat(dirkeyf,'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');%编辑图像名称，使其能存入下级文件夹，且不重名
imwrite(mov.cdata,strc,'bmp');%将图像信息存入文件，以便其他处理程序使用
%imwrite(mov,strc,'bmp');
end
subframe = subframe+1;
end
for k = 120*(subframe-1)+1:FramesNum
mov(k).cdata = read(Move,k);
end
for i = 120*(subframe-1)+1:FramesNum-2
eulerdisdiff(i) = EulerDistanceDiff(mov,i);%调用帧差欧式距离函数
end
x1 = 1:FramesNum-120*subframe + 118;
yeulerdisdiff = eulerdisdiff';%转置
yyeulerdisdiff = yeulerdisdiff(1,120*(subframe-1)+1:FramesNum-2);%取矩阵的第一行
indexde = extremum(yyeulerdisdiff,x1);%调用极值函数，求帧差欧式距离的极值
yyde = yyeulerdisdiff(indexde);%求极值点对应的函数值
maxyyde = max(yyde);%
minyyde = min(yyde);%求最小值
midyyde = (maxyyde+minyyde)/2;
selindexde = indexde(yyde>midyyde);%去掉小于中间值得极值点
Len = numel(selindexde);%经过筛选的极值点的个数
keyindexde = selindexde(1:Len);%选取筛选到的所有极值点
realk = Len;
for j = 1:realk
indexset{subframe}(j) = keyindexde(j)+120*(subframe-1);
n = keyindexde(j)+120*(subframe-1);
mov = read(Move,keyindexde(j)+120*(subframe-1));%将avi视频信息读入帧
strc = strcat(dirkeyf,'\',num2str(keyindexde(j)+120*(subframe-1)),'.bmp');%编辑图片名称，使其能存入下级文件夹，且不重名
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