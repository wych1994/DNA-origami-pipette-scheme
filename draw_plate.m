function draw_plate(p_i,plate_name,shift)

num_w=p_i.num_w;
num_h=p_i.num_h;
well_d=p_i.well_d;
inner_gap=p_i.inner_gap;
ide_pad=p_i.side_pad;
plate_w=p_i.plate_w;
plate_h=p_i.plate_h;
center_M=p_i.center_M;
digits_pos=p_i.digits_pos;
letter_pos=p_i.letter_pos;
digits_pos=p_i.digits_pos;
letter_pos=p_i.letter_pos;
center_M=p_i.center_M;
letter_stock=p_i.letter_stock;



%draw plate
rectangle('Position',[shift 0 plate_w plate_h],'LineWidth',2);
%draw plate labels
for i=1:12
    text(digits_pos{i}(1)+shift,digits_pos{i}(2),num2str(i),'HorizontalAlignment','center')
end
for i=1:8
    text(letter_pos{9-i}(1)+shift,letter_pos{9-i}(2),letter_stock{i},'HorizontalAlignment','center')
end
%draw plate name
text(plate_w/2+shift,plate_h*1.15,plate_name,'HorizontalAlignment','center','Interpreter','none')
hold on
for i=1:12
    for j=1:8
        viscircles([center_M{i,j}(1)+shift,center_M{i,j}(2)],well_d/2,'color','k','LineWidth',1);
        hold on
    end
end