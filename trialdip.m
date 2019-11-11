clc;
clear;
Ic=imread('comb.tiff');%take input image
Ic(:,:,4) = []; % get rid of transparency values
Ic=rgb2gray(Ic);%convert to grayscale
[m,n]=size(Ic);
%disp(m);
%disp(n);
[histy,Ik]=LBPhist(Ic);%Obtain LBP operated version of image
h=imrect; %allow user to select a rectangular region containing texture 1
position = wait(h);%wait for user to finish selecting
pos = getPosition(h);%find dimensions of rectangle
disp(pos);
mask1 = createMask(h);%make evrything except selcted region black, and selected region white
mask1=im2uint8(mask1);%convert from logical to uint8
mask1=mask1./255;
Ic1=Ik.*mask1;%multiply original image by mask to get only selected region same as original and rest of the image black
pause(3);
pos=ceil(pos);
Ic4=zeros(pos(1,4),pos(1,3));%create an empty matrix the size of the selcted region
Ic4=uint8(Ic4);
for i=pos(1,2):pos(1,2)+pos(1,4) % Create a new image that contains only the rectangular window and gets rid of the unselected black portions
    for j=pos(1,1):pos(1,1)+pos(1,3)
        Ic4((i-(pos(1,2)-1)),(j-(pos(1,1)-1)))=Ic1(i,j);
    end
end
[counts,x] = imhist(Ic4,16);%find histogram of the selected region

counts=counts./(pos(1,3)*pos(1,4));%normalize it
subplot(2,1,1);
stem(x,counts);%plot the histogram
subplot(2,1,2);
imshow(Ic4);%plot the selcted region
disp(sum(counts));%the sum of normallised histogram elements should be 1
%Second texture identification (The exact same Procedure as above is
%repeated for region 2------------------------------------------------
figure,imshow(Ik);
h1=imrect;
position1 = wait(h1);
pos1 = getPosition(h1);
disp(pos1);
mask2 = createMask(h1);
mask2=im2uint8(mask2);
mask2=mask2./255;
Ic11=Ik.*mask2;
pause(3);
pos1=ceil(pos1);
Ic41=zeros(pos1(1,4),pos1(1,3));
Ic41=uint8(Ic41);
for i=pos1(1,2):pos1(1,2)+pos1(1,4)
    for j=pos1(1,1):pos1(1,1)+pos1(1,3)
        Ic41((i-(pos1(1,2)-1)),(j-(pos1(1,1)-1)))=Ic11(i,j);
    end
end
[counts1,x1] = imhist(Ic41,16);

counts1=counts1./(pos1(1,3)*pos1(1,4));
subplot(2,1,1);
stem(x1,counts1);
subplot(2,1,2);
imshow(Ic41);
disp(sum(counts1));
%--------------------------------------------------------------------------------------------------
Icf=Ic;Icf2=Ic; %create two images same as original to segment wrt each of the two textures
for p=26:486
    for q=26:486 %For the entire image. Doesn't start from 1 as the size of the window is 51X51 and there is no paddiing
      
        counts2=findhist(Ik,p,q); %find histogram of a 51X51 window centred at (p,q)
        w=comphist(counts,counts2); % find the error wrt histogram of texture1 
        w2=comphist(counts1,counts2);%find the error wrt histogram of texture2 
        if w>0.22
            Icf(p,q)=255; %Setting error threshold for segmentation wrt texture 1, if it crosses threshold, pixel is white, else original.
        end
        if w2>0.16
            Icf2(p,q)=255;%Setting error threshold for segmentation wrt texture 1
        end
    end
end
figure,imshow(Icf);% display segmented image wrt texture 1
figure,imshow(Icf2);%display segmented image wrt texture 2

