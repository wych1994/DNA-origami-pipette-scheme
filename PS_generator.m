clear all
close all
clc
%%%%user defined area
User_name='User X';
Structure_name='DNA origami Pre-Stock Pipette Scheme';
date_order='2345/06/07';
plate_company='IDT';
Plate1_name='Plate A';
Plate2_name='Plate B';
scaffold_type='8064';
nmole_scale=25;
%%%%%%%%%%%%%%%%%%%
oligo_placement_p1=read_plate_spreadsheet(Plate1_name);
oligo_placement_p2=read_plate_spreadsheet(Plate2_name);
oligo_placement=[oligo_placement_p1;oligo_placement_p2];
% oligo_placement_vague={
%     [Plate1_name],['core'],[{'FromA1ToC2'},{'F12'},{'G11'}];...
%     [Plate1_name],['side'],[{'FromH1ToH11'},{'H12'}];...
%     [Plate2_name],['replacement'],[{'FromA1ToF3'}];...
%     [Plate2_name],['OHs'],[{'G1'},{'G2'}];...
%     [Plate2_name],['test'],[{'FromG5ToG9'},{'G11'}];...
%     };
% oligo_placement=parse_vagueinput(oligo_placement_vague);

% oligo_cluster_color=rand(size(oligo_placement,1),3); %random color
oligo_cluster_color=[
    [1 0 0]
    [0 1 0]
    [0 0 1]
    [0 1 1]
    [1 0 1]
    [1 1 0]
    [0 0 0]
    [0 0.4470 0.7410]
    ];
%plate info
p_i.num_w=12;
p_i.num_h=8;
p_i.well_d=10;
p_i.inner_gap=2;
p_i.side_pad=10;
p_i.plate_w=p_i.num_w*p_i.inner_gap+p_i.num_w*p_i.well_d+p_i.side_pad;
p_i.plate_h=p_i.num_h*p_i.inner_gap+p_i.num_h*p_i.well_d+p_i.side_pad;
p_i.center_M=cell(p_i.num_w,p_i.num_h);
p_i.digits_pos=cell(p_i.num_w,1);
p_i.letter_pos=cell(p_i.num_h,1);
for i=1:p_i.num_w
    p_i.digits_pos{i}=[p_i.side_pad+p_i.well_d/2+(p_i.well_d+p_i.inner_gap)*(i-1),p_i.plate_h-p_i.side_pad/2];
end
for i=1:p_i.num_h
    p_i.letter_pos{i}=[p_i.side_pad/2,p_i.inner_gap+p_i.well_d/2+(p_i.well_d+p_i.inner_gap)*(i-1)];
end
for i=1:p_i.num_w
    for j=1:p_i.num_h
        p_i.center_M{i,j}=[p_i.side_pad+p_i.well_d/2+(p_i.well_d+p_i.inner_gap)*(i-1),p_i.inner_gap+p_i.well_d/2+(p_i.well_d+p_i.inner_gap)*(j-1)];
    end
end
p_i.letter_stock={'A','B','C','D','E','F','G','H'};


%set up canvas
f=figure;
f.Position = [100 100 1000 540];
axis off
set(gcf, 'color',[1,1,1])
xlim([-30 470])
ylim([-120 150])

%creator info
date_today=datestr(datenum(num2str(yyyymmdd(datetime('today'))),'yyyymmdd'),'yyyy/mm/dd');
c_i={['Created by:'],[User_name],[],['Date Created:'],[date_today],[],['Plate Ordered:'],...
    [date_order,' from ',plate_company],['in ',num2str(nmole_scale),' nmole scale']};
text(p_i.plate_w*2+100,p_i.plate_h/2,c_i,'HorizontalAlignment','center')
%structure info
text(p_i.side_pad+p_i.plate_w,p_i.plate_h*1.3,Structure_name,'HorizontalAlignment','left','FontSize',20)
text(p_i.side_pad,-10,strcat('Scaffold= ',scaffold_type),'HorizontalAlignment','left')
%draw plate
draw_plate(p_i,Plate1_name,0)      %plate_1
draw_plate(p_i,Plate2_name,p_i.plate_w+20)  %plate_2
% draw PS
if size(oligo_placement,1)>6
    vstack=0;
else
    vstack=1;
end
for m_idx=1:size(oligo_placement,1)  %draw each module one by one
    oligo_placement_m_idx=oligo_placement(m_idx,:);
    draw_oligo(oligo_placement_m_idx,p_i,Plate1_name,Plate2_name,oligo_cluster_color(m_idx,:))
    label_gap=15;
    if vstack==1
        plot(50,-label_gap*m_idx-20,'.','color',oligo_cluster_color(m_idx,:),'MarkerSize',40)
        text(50,-label_gap*m_idx-20,strcat({'     '},oligo_placement{m_idx,2}),'HorizontalAlignment','left')
        hold on
    else

        if rem(m_idx,2)==1
            plot(30,-label_gap*ceil(m_idx/2)-20,'.','color',oligo_cluster_color(m_idx,:),'MarkerSize',40)
            text(30,-label_gap*ceil(m_idx/2)-20,strcat({'     '},oligo_placement{m_idx,2}),'HorizontalAlignment','left')
            hold on
        else
            plot(200,-label_gap*ceil(m_idx/2)-20,'.','color',oligo_cluster_color(m_idx,:),'MarkerSize',40)
            text(200,-label_gap*ceil(m_idx/2)-20,strcat({'     '},oligo_placement{m_idx,2}),'HorizontalAlignment','left')
            hold on
        end
    end
end

saveas(f,'sample_PS','png')
