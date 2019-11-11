function [ w ] = comphist( hist1,hist2 )
hist3=zeros(16,1);
w=0;%initiallise error to 0
for i=1:16
    hist3(i,1)=hist2(i,1)-hist1(i,1);% Subtract corresponding values of each bin in both histograms
    w=w+abs(hist3(i,1));%add the absolute difference to find the net error
end
end


