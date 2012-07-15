% This scripts checks the installation of the PhD face recognition toolbox. 
% 
% All this script does is running a test using all (or at least most) of the 
% functions featured in the PhD toolbox. You can run this script to 
% check, whether the installation script has successfully added all directories
% and subderectories of the toolbox to Matlabs sesrch paths or if you have
% installed the toolbox manually, whether your manual installation was
% successful.
% 
% It should be noted that all components of the toolbox were tested with 
% Matlab version 7.11.0.584 (R2010b) running on Windows 7.
% 
% NOTE: This script assumes that a 453x604 pixel color image 
% called "sample_image.bmp" is located in Matlabs current path. The image is
% usually distibuted with the toolbox, so make sure you do not accidentally
% delete it.
% 
% COMMENT: Note then this script can take a while, since its original
% purpose was to error-check the scripting of the toolbox. Hence, it tests
% most of the functions (i.e., all functions that are also usefull on their 
% own) of the toolbox with a variety of input parameter combinations. 

%% Some init operations
clear all
close all

reportek.msg      = cell(1,20);
reportek.ok       = zeros(1,20);
reportek.test_no  = 0;
disp(sprintf('The script will now check the installation of the PhD toolbox. Please ignore \nany warnings since some dummy data is being generated that maight not behave as real data does.'))
disp(' ')

%% Read test image
disp('Reading test image to check installation...')
X=imread('sample_image.bmp');
XX=imread('sample_face.bmp');
disp('Done.')
disp(' ')

%% Testing functions from "utils" folder

disp('Testing independant functions from "utils" folder.')
ok = 1;

%register_face_based_on_eyes
reportek.test_no = 1;
eyes.x(1)=160;
eyes.y(1)=184;
eyes.x(2)=193;
eyes.y(2)=177;
try
  Y = register_face_based_on_eyes(X,eyes,[128 100]);
  [a,b,c] = size(Y);
  if ~(a==128 && b==100)
      ok = 0;
  end
  Y = register_face_based_on_eyes(X,eyes);
  [a,b,c] = size(Y);
  if ~(a==128 && b==128)
      ok = 0;
  end
  Y = register_face_based_on_eyes(X,eyes,100);
  [a,b,c] = size(Y);
  if ~(a==100 && b==100)
      ok = 0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "register_face_based_on_eyes" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "register_face_based_on_eyes" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "register_face_based_on_eyes" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end


%construct_Gabor_filters_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
  filter_bank = construct_Gabor_filters_PhD(8, 5, [128 128]);
  if(~isfield(filter_bank,{'spatial','freq','scales','orient'}))
    ok = 0;
  end
  filter_bank = construct_Gabor_filters_PhD(6, 5, 100);
  if(~isfield(filter_bank,{'spatial','freq','scales','orient'}))
    ok = 0;
  end
  filter_bank = construct_Gabor_filters_PhD(8, 4, [100 128]);
  if(~isfield(filter_bank,{'spatial','freq','scales','orient'}))
    ok = 0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "construct_Gabor_filters_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "construct_Gabor_filters_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "construct_Gabor_filters_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end




%compute_kernel_matrix_PhD
ok = 1;
X1=imresize(mean(X,3),[128,128]);
Y= repmat(X1(:),1,5);
reportek.test_no = reportek.test_no + 1;
try
  kermat = compute_kernel_matrix_PhD(Y,Y,'poly',[1 2]);
  if(isempty(kermat))
    ok = 0;
  end
  kermat = compute_kernel_matrix_PhD(Y,Y,'fpp',[1 0.5]);
  if(isempty(kermat))
    ok = 0;
  end
  kermat = compute_kernel_matrix_PhD(Y,Y,'tanh');
  if(isempty(kermat))
    ok = 0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "compute_kernel_matrix_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "compute_kernel_matrix_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "compute_kernel_matrix_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end



%resize_pc_comps_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
  filter_bank = construct_Gabor_filters_PhD(8,5, [128 128]);
  [pc,EO] = produce_phase_congruency_PhD(XX,filter_bank);
  feature_vector_extracted_from_X = resize_pc_comps_PhD(pc, 32); 
  if(length(feature_vector_extracted_from_X)~=3528)
    ok = 0;
  end  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "resize_pc_comps_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "resize_pc_comps_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "resize_pc_comps_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end



%% Testing functions from "plots" folder

disp('Testing independant functions from "plots" folder.')
ok = 1;

%plot_ROC_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
true_scores = 0.5 + 0.9*randn(1000,1);
false_scores = 3.5 + 0.9*randn(1000,1);
try
  [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
  h=plot_ROC_PhD(1-ver_rate, miss_rate);
  h=plot_ROC_PhD(1-ver_rate, miss_rate, 'b',4);
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "plot_ROC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "plot_ROC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "plot_ROC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
close all




%plot_EPC_PhD
ok = 1;
true_scores = 0.5 + 0.9*randn(1000,1);
false_scores = 3.5 + 0.9*randn(1000,1);
true_scores1 = 0.6 + 0.8*randn(1000,1);
false_scores1 = 3.3 + 0.8*randn(1000,1);
reportek.test_no = reportek.test_no + 1;
try
  [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores, false_scores);
  [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,rates,20);
  h=plot_EPC_PhD(alpha, errors);
  h=plot_EPC_PhD(alpha, errors,'b',4);  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "plot_EPC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "plot_EPC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "plot_EPC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
close all






%plot_CMC_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
    ranks       = 1:10;
    rec_rates   = [0.6 0.7 0.75 0.78 0.8 0.83 0.87 0.95 0.99 1];
    h=plot_CMC_PhD(rec_rates, ranks);
    axis([1 10 0 1])
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "plot_CMC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "plot_CMC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "plot_CMC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
close all





%% Testing functions from "features" folder

disp('Testing independant functions from "features" folder.')

%filter_image_with_Gabor_bank_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
[a,b,c] = size(XX);
filter_bank = construct_Gabor_filters_PhD(8, 5, [a b]);
try
  filtered_image = filter_image_with_Gabor_bank_PhD(XX,filter_bank,1);
  if(length(filtered_image)~=655360)
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "filter_image_with_Gabor_bank_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "filter_image_with_Gabor_bank_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "filter_image_with_Gabor_bank_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
close all



%linear_subspace_projection_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
X=double(XX);
try
  model.P = randn(length(X(:)),1);    %random 10 dimensional model
  model.dim = 10;
  model.W = randn(length(X(:)),10);
  feat = linear_subspace_projection_PhD(X(:), model, 0);
  if(length(feat)~=10)
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "linear_subspace_projection_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "linear_subspace_projection_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "linear_subspace_projection_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear model feat



%nonlinear_subspace_projection_PhD
X=double(imread('sample_face.bmp'));
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
  training_data = randn(length(X(:)),10);
  model = perform_kpca_PhD(training_data, 'poly', [0 2]);
  feat = nonlinear_subspace_projection_PhD(X(:), model);
  if(length(feat)~=9)
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "nonlinear_subspace_projection_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "nonlinear_subspace_projection_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "nonlinear_subspace_projection_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear model feat training_data


%produce_phase_congruency_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
  filter_bank = construct_Gabor_filters_PhD(8,5, [128 128]);
  [pc,EO] = produce_phase_congruency_PhD(X,filter_bank);
  [a,b] = size(pc);
  [c,d] = size(EO);
  if~(a==1 && b == 8)
    ok =0;
  end
  if~(c==5 && d == 8)
    ok =0;
  end
  [a,b] = size(pc{1});
  if~(a==128 && b == 128)
    ok =0;
  end
  
  filter_bank = construct_Gabor_filters_PhD(8,5, [128 100]);
  X1 = imresize(X,[128,100]);
  [pc,EO] = produce_phase_congruency_PhD(X1,filter_bank,4);
  [a,b] = size(pc);
  [c,d] = size(EO);
  if~(a==1 && b == 8)
    ok =0;
  end
  if~(c==4 && d == 8)
    ok =0;
  end
  [a,b] = size(pc{1});
  if~(a==128 && b == 100)
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "produce_phase_congruency_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "produce_phase_congruency_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "produce_phase_congruency_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear pc EO




%perform_pca_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
Xx=randn(300,100);
try
  model = perform_pca_PhD(Xx,rank(Xx)-1);
  if~(isfield(model,{'P','dim','W','train'}))
    ok =0;
  end
  
  model = perform_pca_PhD(Xx,20);
  if~(isfield(model,{'P','dim','W','train'}))
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "perform_pca_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "perform_pca_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "perform_pca_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear model Xx




%perform_lda_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
Xx=randn(300,100);
ids = repmat(1:25,1,4);
try
  model = perform_lda_PhD(Xx,ids,24);
  if~(isfield(model,{'P','dim','W','train'}))
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "perform_lda_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "perform_lda_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "perform_lda_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear Xx model ids




%perform_kpca_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
Xx=randn(300,100);
try
  model = perform_kpca_PhD(Xx, 'poly', [0 2], 90);
  if~(isfield(model,{'K','dim','W','train','J','eigs','typ','X'}))
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "perform_kpca_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "perform_kpca_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "perform_kpca_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear Xx model 






%perform_kfa_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
Xx=randn(300,100); %generate 100 samples with a dimension of 300
ids = repmat(1:25,1,4); %generate 25-class id vector
try
  model = perform_kfa_PhD(Xx, ids, 'poly', [0 2], 24); %generate KFA model
  if~(isfield(model,{'K','dim','W','train','J','eigs','typ','X'}))
    ok =0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "perform_kfa_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "perform_kfa_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "perform_kfa_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear Xx model ids


%% Testing functions from "eval" folder

disp('Testing independant functions from "eval" folder.')

%produce_ROC_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
true_scores = 0.5 + 0.9*randn(1000,1);
false_scores = 3.5 + 0.9*randn(1000,1);
try
  [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores,5000);
  if(length(ver_rate)~=5001)
      ok=0;
  end
  if(length(miss_rate)~=5001)
      ok=0;
  end
  if~(isfield(rates,{'minHTER_er'}))
      ok=0;
  end
  
  [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
  if(length(ver_rate)~=2501)
      ok=0;
  end
  if(length(miss_rate)~=2501)
      ok=0;
  end
  if~(isfield(rates,{'minHTER_er'}))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "produce_ROC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "produce_ROC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "produce_ROC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear ver_rate miss_rate rates




%produce_EPC_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
true_scores = 0.5 + 0.9*randn(1000,1);
false_scores = 3.5 + 0.9*randn(1000,1);
true_scores1 = 0.6 + 0.8*randn(1000,1);
false_scores1 = 3.3 + 0.8*randn(1000,1);
try
  [ver_rate, miss_rate, rates] = produce_ROC_PhD(true_scores,false_scores);
  [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,rates,20);
  if(length(alpha)~=20)
      ok=0;
  end
  if(length(errors)~=20)
      ok=0;
  end
  if~(isfield(rates_and_threshs,{'minHTER_er'}))
      ok=0;
  end
  
  [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1,[],40);
  if(length(alpha)~=40)
      ok=0;
  end
  if(length(errors)~=40)
      ok=0;
  end
  if~(isempty(rates_and_threshs))
      ok=0;
  end
  
  
  [alpha,errors,rates_and_threshs] = produce_EPC_PhD(true_scores,false_scores,true_scores1,false_scores1);
  if(length(alpha)~=10)
      ok=0;
  end
  if(length(errors)~=10)
      ok=0;
  end
  if~(isempty(rates_and_threshs))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "produce_EPC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "produce_EPC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "produce_EPC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear ver_rate miss_rate rates




%produce_CMC_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
training_data = randn(100,30);
training_ids(1:15)  = 1:15;
training_ids(16:30)  = 1:15;
test_data = randn(100,15);
test_ids = 1:15;
try
  results = nn_classification_PhD(training_data, training_ids, test_data, test_ids, size(test_data,1)-1, 'euc');
  [rec_rates, ranks] = produce_CMC_PhD(results);
  if(isempty(rec_rates))
      ok=0;
  end
  if(isempty(ranks))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "produce_CMC_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "produce_CMC_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "produce_CMC_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear results rec_rates ranks training_data test_data







%evaluate_results_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
try
  n=100;
  train_feature_vectors=[];
  test_feature_vectors=[];
  test_ids = [];
  train_ids = [];
  for i=1:20
      for j=1:10
          train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
          train_ids = [train_ids,i];
          test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
          test_ids = [test_ids,i];
      end
  end    
  results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','all');
  output = evaluate_results_PhD(results,'ID');
  if(isempty(output))
      ok=0;
  end 
  
  n=100;
  train_feature_vectors=[];
  test_feature_vectors=[];
  eval_feature_vectors=[];
  test_ids = [];
  train_ids = [];
  eval_ids = [];
  for i=1:20
      for j=1:10
        if(i<10)
          train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
          train_ids = [train_ids,i];
        end
          test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
          test_ids = [test_ids,i];
          eval_feature_vectors=[eval_feature_vectors,i+1.5*randn(n,1)];
          eval_ids = [eval_ids,i];
      end
  end    
  results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','sep');
  results1 = nn_classification_PhD(train_feature_vectors, train_ids, eval_feature_vectors, eval_ids, n, 'euc','sep');
  output = evaluate_results_PhD(results,'image',results1);
  if(isempty(output))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "evaluate_results_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "evaluate_results_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "evaluate_results_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear results rec_rates ranks training_data test_data




%% Testing functions from "classification" folder

disp('Testing independant functions from "classification" folder.')

%return_distance_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
x  = randn(1,20);
y  = randn(1,20);
invcovar = randn(20,20);
try
  d = return_distance_PhD(x,y);
  if~(isscalar(d) && isnumeric(d))
      ok=0;
  end
  
  d = return_distance_PhD(x,y,'euc');
  if~(isscalar(d) && isnumeric(d))
      ok=0;
  end
  
  d = return_distance_PhD(x,y,'mahcos',invcovar);
  if~(isscalar(d) && isnumeric(d))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "return_distance_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "return_distance_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "return_distance_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear ver_rate miss_rate rates




%nn_classification_PhD
ok = 1;
reportek.test_no = reportek.test_no + 1;
n=100;
train_feature_vectors=[];
test_feature_vectors=[];
test_ids = [];
train_ids = [];    
for i=1:20
   for j=1:10
       train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
       train_ids = [train_ids,i];
       test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
       test_ids = [test_ids,i];
   end
end
try
  results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','all');
  if~(isfield(results,{'match_dist','same_cli_id','mode','horizontal_ids','vertical_ids','dist','dim'}))
      ok=0;
  end
  
   n=100;
   train_feature_vectors=[];
   test_feature_vectors=[];
   test_ids = [];
   train_ids = [];
   for i=1:20
       for j=1:10
            if(i<10)
                train_feature_vectors=[train_feature_vectors,i+1.5*randn(n,1)];
                train_ids = [train_ids,i];
            end
            test_feature_vectors=[test_feature_vectors,i+1.5*randn(n,1)];
            test_ids = [test_ids,i];
        end
   end
  
  results = nn_classification_PhD(train_feature_vectors, train_ids, test_feature_vectors, test_ids, n, 'euc','sep');
  if~(isfield(results,{'mode','client_dist','same_cli_id','client_horizontal_ids','client_vertical_ids','imp_dist','same_imp_id'}))
      ok=0;
  end
  
  if(ok)
    reportek.msg{reportek.test_no} = 'Function "nn_classification_PhD" is working properly.';
    reportek.ok(reportek.test_no)  = 1;
  else
    reportek.msg{reportek.test_no} = 'Function "nn_classification_PhD" is NOT working properly.';
    reportek.ok(reportek.test_no)  = 0; 
  end   
catch
  reportek.msg{reportek.test_no} = 'Function "nn_classification_PhD" is NOT working properly.';
  reportek.ok(reportek.test_no)  = 0;  
end
clear ver_rate miss_rate rates





disp('Done.')


%% report
disp(' ')
disp(' ')
disp('|========================================================================================|')
disp(' ')
disp('VALIDATION report:')
disp(' ')
for i=1:length(reportek.ok)
    disp(reportek.msg{i}) 
end
disp(' ')
disp('|========================================================================================|')
disp(' ')
disp('SUMMARY:')
disp(' ')
if sum(reportek.ok == 0) > 0 
    disp('The following functions reported some errors in their execution.');
    disp(' ')
    for i=1:length(reportek.ok)
        if(reportek.ok(i) == 0)
            disp(reportek.msg{i}) 
        end
    end
else
    disp('All functions from the toolbox are working ok.') 
end
disp(' ')
disp('|========================================================================================|')






























