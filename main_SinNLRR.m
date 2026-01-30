clc
clear
addpath('.\single_data');
addpath('.\single_data\data');
addpath('E:\王传远\SinNLRR-master')
% in_X=load('Test_19_Engel_log.txt');
% label=load('Test_19_Engel_label.txt');

dataset = {'1_mECS', '2_Kolod', '3_Pollen', '4_Usoskin','5_Zeisel'}; %% four datasets tested on the paper
dataset2 = {'Buettner', 'Deng', 'Ginhoux', 'Macosko','Tasic','Ting','Treutlin','Zeisel','Q','Y'}; %% four datasets tested on the paper
for num=9:9
load(['Data_',dataset2{num},'.mat'])
label=true_labs;
n_space = length(unique(label));
[X,] = FilterGenesZero(in_X);
[n,m]=size(X);
X = double(normalize(X'));
for i=16:30
    alpha=0.1+i*0.2;
    Z = lrr_relaxed(X,alpha);
    [localX, ~] = localize(abs(Z));
    %z_rate = sum(sum(localX~=0))/(n*n);
    min_neighbour = min(sum(localX~=0,1));
    %max_neighbour = max(sum(localX~=0,1));
    if ((n<1000 &&min_neighbour>3)||(n>=1000 &&min_neighbour>1))          
        similarity = localX+localX';    
        grps = SpectralClustering2(similarity, n_space);
        NMI(num)=Cal_NMI(label, grps);
        ARI(num)=Cal_ARI(label, grps);
        fprintf('%s数据集ARI： %f\n',dataset2{num},ARI(num));
        break;
    end
    %fprintf('%f\t%f\t%f\t%f\t%f\t%f\t%f\n',alpha,z_rate,min_neighbour,max_neighbour,mean(col_cov),missrate,misARI);
end
end
 ydata = tsne_bo(Z,label,2);
