function [n] = deci( I,i,j )
k=zeros(1,9);%label center pixel as A
A=I(i,j);
l=1;
 
for x=i-1:i+1
    for y=j-1:j+1 %Select a 3X3 window around A
       
        if (I(x,y)>=A) %Check if neighbouring pixel is greater than or equal to A(thresholding). If yes, make it 1
            k(1,l)=1;
        else
            k(1,l)=0;%Otherwise, make the pixel 0
        end
        l=l+1;
    end
end
n= k(1,1).*1 + k(1,2).*2 +k(1,3).*4 +k(1,4).*8+k(1,6).*16 + k(1,7).*32 + k(1,8).*64 + k(1,9).*128 ;
%In the above statement, thresholded pixels ar multiplied with decimal
%values corresponding to their position. n is the final decimal returned

       
end

