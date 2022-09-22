%------------------- This is a demo of the proposed MKC-DNM -------------------
clear;clc

datasetpath = '.\';
path_eval = '.\evaluation\';
path_mea = '.\measure\';
savepath = '.\results\';

addpath(genpath(path_eval));
addpath(genpath(path_mea));

dataNameset = {'bbcsport_2view'};
for id = 1:1
    %--------------------------------- Load -----------------------------------
    dataName = dataNameset{id};
    disp(dataName);
    
    load([datasetpath,'datasets\',dataName,'_Kmatrix'],'KH','Y');
    KH = kcenter(KH);
    KH = knorm(KH);
    
    numclass = length(unique(Y)); 
    numker = size(KH,3); 
    num = size(KH,1); 
    dataset_imf=[num numclass numker];
    
    for p = 1:numker
        KH(:,:,p)=(KH(:,:,p)+KH(:,:,p)')/2;
    end
    %------------------------- The Proposed MKC_DNM ---------------------------
    tic;
    [H] = MKC_DNM(KH,numclass);
    [res_mean,res_std]= myNMIACCV2(H,Y,numclass);
    timecost = toc;
    %---------------------------- Print and Save ------------------------------
    fprintf('ACC: %f, NMI: %f, Purity: %f, ARI: %f\n', res_mean(1), res_mean(2), res_mean(3), res_mean(4));
    save([savepath,dataName,'_performance.mat'],'res_mean','res_std','H','timecost')
end

