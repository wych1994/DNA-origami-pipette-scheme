function draw_oligo(oligo_placement,p_i,Plate1_name,Plate2_name,oligo_cluster_color)
if oligo_placement{1}==Plate1_name
    shift=0;
    
elseif oligo_placement{1}==Plate2_name
    shift=p_i.plate_w+20;
else
    error('Wrong Plate')
end
    
%     letter_idx=regexpi(oligo_placement{1}, '[a-zA-Z]');
    oligo_cell=oligo_placement{3};
    num_oligos= length(oligo_cell);
    for oligo_idx=1:num_oligos
%         if oligo_idx~=num_oligos
%             inputstr=oligo_placement{1}(letter_idx(oligo_idx):letter_idx(oligo_idx+1)-1);
%         else
%             inputstr=oligo_placement{1}(letter_idx(oligo_idx):end);
%         end
        inputstr=oligo_cell{oligo_idx};
        plate_pos=parse_plate_placement(inputstr);
        j=plate_pos(1);
        i=plate_pos(2);
        plot(p_i.center_M{i,p_i.num_h+1-j}(1)+shift,p_i.center_M{i,p_i.num_h+1-j}(2),'.','MarkerSize',40,...
            'color',oligo_cluster_color);
        hold on
    end
    
end