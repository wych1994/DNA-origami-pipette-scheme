function plate_pos=parse_plate_placement(inputstr)
plate_pos=zeros(2,1);
letter=inputstr(1);

if letter=='A'
    plate_pos(1)=1;
elseif letter=='B'
    plate_pos(1)=2;
elseif letter=='C'
    plate_pos(1)=3;
elseif letter=='D'
    plate_pos(1)=4;
elseif letter=='E'
    plate_pos(1)=5;
elseif letter=='F'
    plate_pos(1)=6;
elseif letter=='G'
    plate_pos(1)=7;
elseif letter=='H'
    plate_pos(1)=8;
else
    error('Wrong Letter')
end

if length(inputstr)==2
    digit=inputstr(2);
    plate_pos(2)=str2double(digit);
elseif length(inputstr)==3
    digit=inputstr(2:3);
    plate_pos(2)=str2double(digit);
else
    error('Wrong Digits')
end



end