function oligo_placement=read_plate_spreadsheet(Plate_name)
filename=strcat(Plate_name,'.xls');
data=readtable(filename);
oligo_placement=cell(1,3);

cluster_name=cell(96,1);
%parse all oligo name with its name+num
for i=1:96
idv_name=data{i,2};
if ~isempty(idv_name{1})
num = regexp(idv_name,'\d*','Match');
cluster_name{i}=idv_name{1}(1:length(idv_name{1})-length(num{1}{1}));
else
    continue
end
end
%classify
cluster_name_group={};
for i=1:96
    nominal_name=cluster_name{i};
    if isempty(cluster_name_group)
    cluster_name_group=[cluster_name_group,nominal_name];
    elseif ~strcmp(cluster_name_group{end},nominal_name)  %add when name different
        cluster_name_group=[cluster_name_group,nominal_name];
    else
        continue
    end
end
% fill plate name and cluster name
oligo_placement=cell(length(cluster_name_group),3);
for i=1:length(cluster_name_group)
oligo_placement{i,1}=Plate_name;
oligo_placement{i,2}=cluster_name_group{i};
end
% fill position
cluster_count=1;
for i=1:96
    if ~isempty(data{i,2}{1})
        if contains(data{i,2} , cluster_name_group{cluster_count})
            oligo_placement{cluster_count,3}=[oligo_placement{cluster_count,3},data{i,1}];
        else 
            cluster_count=cluster_count+1;
            oligo_placement{cluster_count,3}=[oligo_placement{cluster_count,3},data{i,1}];
        end
    else
        continue
    end
end


