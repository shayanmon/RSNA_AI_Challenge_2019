load('Stage1Train.mat')
%% 

% obtain labels
labels = zeros(length(stage1train),1);
for i = 1:length(labels)
    labels(i) = stage1train{i,2};
end

% reformat subtypes into 2D array
num_patients = length(labels)/6;
new_labels_dataset = zeros(num_patients,6);
new_patient_id = 0;
for j = 1:6:length(labels)
    new_patient_id = new_patient_id + 1;
    new_labels_dataset(new_patient_id,:) = labels(j:j+5);
end

% convert dataset into working cell array
new_labels_dataset = num2cell(new_labels_dataset);

% parse subtype from patient ID
patient_ids = cell(num_patients,1);
for i = 1:num_patients
    patient_ids{i,1} = cellfun(@(s)s(4:12),stage1train{i,1},'UniformOutput',false);
end

dataset = horzcat(patient_ids,new_labels_dataset);

save('Reorganized_dataset.mat','dataset');
csvwrite('Reorganized_dataset.csv','dataset');
%% convert dataset into submission-ready column

final_dataset = final_dataset(:);
