function [hist1,I2 ] = LBPhist( I )
%imshow(I);
hist1=zeros(1,16);
I2=I;
for m=2:511
    for n=2:511 % For the entire image barring edge pixels, as there is no padding
        d=deci(I,m,n); %deci function is called for each pixel in the image, to obtain a decimal value for each pixel 
        I2(m,n)=d;%the decimal value is assigned as the pixel intensity
        
        for h=0:15
            if ((d>=h.*16) && (d<(h+1).*16))%The histogram of this LBP operated image is calculated. It has 16 bins.
                hist1(h+1)=hist1(h+1)+1; %every time a value lies in the above range, the value of corresponding bin is incremented by 1.
            end
        end
        
        %{
        for h=1:256
            if (d==h)
                hist1(1,h)=hist1(1,h)+1
            end
        end
        %}
    end
end

%subplot(2,2,1);
%imshow(I);
%subplot(2,2,2);

imshow(I2);% The LBP operated image is displayed

hist1=hist1./148962;%510X510
%subplot(2,2,3);
 %stem(hist1);   
end

