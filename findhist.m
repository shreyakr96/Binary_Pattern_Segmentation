function [ hist1 ] = findhist( I,i,j )
Il=zeros(1,2601);
Il=uint8(Il);%convert from double to uint8 (format for storing images)
k=1;
for m=i-25:i+25
    for n=j-25:j+25 %Create a 51X51 window with I(i,j) as center pixel
        Il(1,k)=I(m,n);%Store all these 2601 values in an array
        k=k+1;
    end
end
[hist1,x1] = imhist(Il,16);%find the histogram of this array
hist1=hist1./2601;%normalize it

end

