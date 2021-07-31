%Function to find the peak values and positions
%Input: value: The input matrix;
%       if type is 'number', offset is the number of peak values desired;
%       if type is 'threshold', peaks larger than the threshold in offset
%       are desired;
%       if type is 'percent', peaks, whose difference with the minimum value
%       in the matrix, larger than a particular percent of the difference
%       between the maximum and the minimum in the matrix are desired.
%       Offset now is the percent value from 0 to 100.
%Output: YC: The peak values
%        IC: The positions of the desired peaks
function [YC IC]=peak(value,offset,type)
if strcmp(type,'number') && offset==1
    %If only the maximum is needed,just find it
    if size(value,1)==1
        [YC IC]=max(value);
        IC=[1 IC];
    else
        if size(value,2)==1
            [YC IC]=max(value);
            IC=[IC 1];
        else
            [YC I1]=max(value);
            [YC I2]=max(YC);
            IC=[I1(I2) I2];
        end
    end
else
    s=size(value);
    minimum=min(min(value));
    valuex=[minimum*ones(1,s(2)+2);
        minimum*ones(s(1),1) value minimum*ones(s(1),1);
        minimum*ones(1,s(2)+2)];
    
    %First find all the peaks
    Y=[];
    I=[];
    for n=1:s(1)
        for m=1:s(2)
            maxmode=1;
            for i=-1:1
                for j=-1:1
                    if valuex(n+1+i,m+1+j)>valuex(n+1,m+1)
                        maxmode=0;
                    end
                end
            end
            if maxmode==1
                Y=[Y; valuex(n+1,m+1)];
                I=[I; n m];
            end
        end
    end
    
    %Deside the peaks needed
    YC=[];
    IC=[];
    if strcmp(type,'number')
        if offset>length(Y)
            offset=length(Y);
        end
        for k=1:offset
            [Yt It]=max(Y);
            YC=[YC;Yt];
            IC=[IC;I(It,:)];
            Y(It)=minimum;
        end
    else
        if strcmp(type,'threshold')
            for k=1:length(Y)
                if Y(k)>=offset
                    YC=[YC;Y(k)];
                    IC=[IC;I(k,:)];
                end
            end
            
        else
            if strcmp(type,'percent')
                distance=max(Y)-minimum;
                for k=1:length(Y)
                    if (Y(k)-minimum)/distance*100>=offset
                        YC=[YC;Y(k)];
                        IC=[IC;I(k,:)];
                    end
                end
            end
        end
    end
end