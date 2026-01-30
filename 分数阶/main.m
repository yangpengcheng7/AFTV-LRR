clc
clear
addpath('E:\单细胞文献\各种代码\data')
% in_X=load('Test_13_Darmanis.txt');
% label=load('Test_13_Darmanis_label.txt');
% in_X=load('Test_19_Engel_log.txt');
%  label=load('Test_19_Engel_label.txt');
for num=5:5
 load('Data_Treutlin ATVLRR.mat')
 in_X=double(in_X);
 label=true_labs;
n_space = length(unique(label));
[X,] = FilterGenesZero(in_X);
[n,m]=size(X);
X = normalize(X');
for i=1:15
    for j=1:4
        alpha=0.1*i;
        mu=10^(-2+j);
        Z= ATV_lrr_relaxed(X,alpha,mu); 
        [localX, ~] = localize(abs(Z));
        z_rate(num,i) = sum(sum(localX~=0))/(n*n);
        min_neighbour(num,i)  = min(sum(localX~=0,1));
        max_neighbour(num,i) = max(sum(localX~=0,1));  
        similarity = localX+localX';    
        grps = SpectralClustering(similarity, n_space);
        NMI(j,i)=Cal_NMI(label, grps);
        ARI(j,i) = Cal_ARI(label, grps);
        fprintf('数据集ARI： %f\n',ARI(j,i));
    end
end
end
