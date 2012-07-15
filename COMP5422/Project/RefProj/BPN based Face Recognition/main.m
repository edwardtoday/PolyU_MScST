% BPN BASED FACE RECOGONITION METHOD PERFORMED ON LOW RESOLUTION IMAGES
% Program designed by Anandh K.R - FINAL year M.E., 
% Guided by Prof.Esther Annelin Kala James HOD/ ECE, TPGIT. Vellore.
         
clear memory
clear all
clc
close all
tic;
% To open the browse option in the front end we fix the initial directory paths
TrainDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select the path of training images' );

P=[196    35   234   232    59   244   243    57   226; ...
   188    15   236   244    44   228   251    48   230; ...    
   246    48   222   225    40   226   208    35   234]'; ...
   % testing images 
N=[196    35   234   232    59   244   243    57   226; ...
   188    15   236   244    44   228   251    48   230; ...    
   246    48   222   225    40   226   208    35   234]';...
   
% N=[208    16   235   255    44   229   236    34   247; ...
%    245    21   213   254    55   252   215    51   249; ...    
%    248    22   225   252    30   240   242    27   244]'; ...
  
% Normalization

P=P/256;
N=N/256;
% display the training images 
% targets
img=[196 35 234;
    232 59 244 ;
    243 57 226]';  

T=img/256;;

% targets
%  T=[0.8    0.06    0.9;
%     0.9    0.17    0.8;
%     0.9    0.13    0.9];
S1=90;   % number of hidden layers
S2=3;   % number of output layers (= number of classes)
[R,Q]=size(P); 
iterations = 120000;      % number of iterations
goal_err = 10e-5;    % goal error
a=0.3;                        % define the range of random variables
b=-0.3;
W1=a + (b-a) *rand(S1,R);     % Weights between Input and Hidden Neurons 9 columns 5 rows
W2=a + (b-a) *rand(S2,S1);    % Weights between Hidden and Output Neurons 9 columns 5 rows
b1=a + (b-a) *rand(S1,1);     % Weights between Input and Hidden Neurons  1 column 5 rows
b2=a + (b-a) *rand(S2,1);     % Weights between Hidden and Output Neurons 1 column 5 rows
n1=W1*P;
A1=logsig(n1);
n2=W2*A1;
A2=logsig(n2);
e=A2-T;
error =0.5* mean(mean(e.*e));    
nntwarn off
for  itr =1:iterations
    if error <= goal_err 
        break
    else
         for i=1:Q
            df1=dlogsig(n1,A1(:,i));
            df2=dlogsig(n2,A2(:,i));
            s2 = -2*diag(df2) * e(:,i);			       
            s1 = diag(df1)* W2'* s2;
            W2 = W2-0.1*s2*A1(:,i)';
            b2 = b2-0.1*s2;
            W1 = W1-0.1*s1*P(:,i)';
            b1 = b1-0.1*s1;
            A1(:,i)=logsig(W1*P(:,i),b1);
            A2(:,i)=logsig(W2*A1(:,i),b2);
         end
            e = T - A2;
            error =0.5*mean(mean(e.*e));
            disp(sprintf('Iteration :%5d        mse :%12.6f%',itr,error));
            mse(itr)=error;
    end
end
threshold=0.7;   % threshold of the system (higher threshold = more accuracy)
% training images result
TrnOutput=real(A2);
TrnOutput=real(A2>threshold);
% Testing the neural network and applying test images to NN
%n1=W1*N;
n1=W1*N;
A1=logsig(n1);
n2=W2*A1;
A2test=logsig(n2);
% testing images result
%TstOutput=real(A2test)
TstOutput=real(A2test>threshold);

% recognition rate
wrong=size(find(TstOutput-T),1);
TestDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select the path of testing images');
prompt = {'Enter test image name (a number between 1 to 10):'};
dlg_title = 'BPN Based Face Recognition System';
num_lines= 1;
def = {'1'};
TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.bmp');
im = imread(TestImage);
toc;

recognition_rate=abs(50*(size(N,2)-wrong)/size(N,2))

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = face(T);
OutputName = recog(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

imshow(im)
title('Image to be tested');
figure,imshow(SelectedImage);
title('Equivalent Image');
disp('Face Recognition successful');

