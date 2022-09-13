function oligo_placement_parsed=parse_vagueinput(oligo_placement_vague)
% Plate1_name='plate 1';
% Plate2_name='plate 2';
% oligo_placement_vague={
%     [Plate1_name],['core'],[{'FromA1ToF10'},{'F12'},{'G11'}];...
%     [Plate1_name],['side'],[{'FromH1ToH11'},{'H12'}];...
%     [Plate2_name],['replacement'],[{'FromA1ToF3'}],;...
%     [Plate2_name],['OHs'],[{'G1'},{'G2'}]};
oligo_placement_cut=oligo_placement_vague;
oligo_placement_cut(:,3)=[];
for m_idx=1:size(oligo_placement_vague,1)
    slicedcell=oligo_placement_cut(m_idx,:);
    for oligo_cluster_idx=1:length(oligo_placement_vague{m_idx,3})

        from_idx = strfind(oligo_placement_vague{m_idx,3}{oligo_cluster_idx},'From');
        to_idx = strfind(oligo_placement_vague{m_idx,3}{oligo_cluster_idx},'To');
        if length(from_idx)>1
            error('Can you make it easier for me? Such as just one from-to')
        elseif length(from_idx)==1
            start_place=oligo_placement_vague{m_idx,3}{oligo_cluster_idx}(from_idx+4:to_idx-1);
            end_place=oligo_placement_vague{m_idx,3}{oligo_cluster_idx}(to_idx+2:end);

            %     if length(regexpi(end_place, '[a-zA-Z]'))>1
            %         end_place=end_place(1:2);
            %     end

            start_pos=parse_plate_placement(start_place);
            end_pos=parse_plate_placement(end_place);
            num_continous_oligos=((end_pos(1)-1)*12+end_pos(2))-((start_pos(1)-1)*12+start_pos(2))+1;
            fromtocell=cell(1,num_continous_oligos);
            fromtocell{1}=start_place;
            next_place_letter=start_place(1);
            next_place_digits=start_place(2:end);
            for i=2:num_continous_oligos
                if str2double(next_place_digits)<12
                    next_place_digits=num2str(str2double(next_place_digits)+1);
                else
                    next_place_letter=char(double(next_place_letter)+1);
                    next_place_digits='1';
                end
                fromtocell{i}=strcat(next_place_letter,next_place_digits);
            end
            if fromtocell{end}~=end_place
                error('Oligo error')
            end

            slicedcell=[slicedcell,fromtocell];
        else
            fromtocell=oligo_placement_vague{m_idx,3}{oligo_cluster_idx};
            slicedcell=[slicedcell,fromtocell];

        end
    end
    unfold_oligo=slicedcell(3:end);
    slicedcell(3:end)=[];
    true_slicedcell=[slicedcell,{unfold_oligo}];
    oligo_placement_parsed(m_idx,:)=true_slicedcell;
end



% oligo_placement=parse_oligo_placement(oligo_placement_vague);