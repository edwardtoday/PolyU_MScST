% The function produces CMC curve data from the input data
% 
% PROTOTYPE
% [rec_rates, ranks] = produce_CMC_PhD(results)
% 
% USAGE EXAMPLE(S)
% 
%     Example 1:
%       %we randomly generate our training and testing data
%       training_data = randn(100,30);
%       training_ids(1:15)  = 1:15;
%       training_ids(16:30)  = 1:15;
%       test_data = randn(100,15);
%       test_ids = 1:15;
%       results = nn_classification_PhD(training_data, training_ids, test_data, test_ids, size(test_data,1)-1, 'euc');
%       [rec_rates, ranks] = produce_CMC_PhD(results);
%       h=plot_CMC_PhD(rec_rates, ranks);
% 
%
% GENERAL DESCRIPTION
% The function computes CMC (Cumulative match score characteristic) curve
% data from the input data fed to the function through the argument 
% "results". Here, the argument "results" represents a structure generated
% by using either the function "nn_classification_PhD" or the function 
% "nn_classification_open_PhD" from the PhD face recognition toolbox. 
% 
% If the training/gallery/target set contains more than one 
% training/gallery/target image per subject the median value of all 
% matching scores is used when constructing the CMC data. Note that here 
% the average or minimal value could also be used, but we decided to go 
% with the median value that gave the best results in our preliminary 
% experiments.     
% 
% Note that you can use this function with similarity matrices of your own,
% which however, you have to incorporate into a results structure that is
% in more detail described in the "nn_classification_PhD" function of the
% PhD face recognition toolbox.
%
% 
% REFERENCES
% CMC curves are regulary used when assessing identification systems. Some
% information on CMC curves can be found in:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
%
%
% INPUTS:
% results               - a structure containing the similarity matrix
%                         and other meta data based on which the CMC curve 
%                         data is computed; the structure can be generated 
%                         using either the "nn_classification_PhD" or the 
%                         "nn_classification_open_PhD" function (obligatory
%                         argument)
%
% OUTPUTS:
% rec_rates             - a generated vector of recognition rates
%                         corresponding to the ranks in the second output
%                         argument; here the first entry in the vector is
%                         obviously the rank one recognition rate
% ranks                 - a generated vector of ranks at which the 
%                         recognition rates were evaluated.  
%                         
%
% NOTES / COMMENTS
% The function was tested with Matlab ver. 7.9.0.529 (R2009b) and Matlab 
% ver. 7.11.0.584 (R2010b).
% 
% 
% RELATED FUNCTIONS (SEE ALSO)
% nn_classification_open_PhD
% nn_classification_PhD
% plot_CMC_PhD
% produce_ROC_PhD
% produce_EPC_PhD
% 
% 
% ABOUT
% Created:        11.2.2010
% Last Update:    1.12.2011
% Revision:       1.0
% 
%
% WHEN PUBLISHING A PAPER AS A RESULT OF RESEARCH CONDUCTED BY USING THIS CODE
% OR ANY PART OF IT, MAKE A REFERENCE TO THE FOLLOWING PUBLICATIONS:
% 
% Štruc V., Pavešic, N.: The Complete Gabor-Fisher Classifier for Robust 
% Face Recognition, EURASIP Advances in Signal Processing, vol. 2010, 26
% pages, doi:10.1155/2010/847680, 2010.
%
% Štruc V., Pavešic, N.:Gabor-Based Kernel Partial-Least-Squares 
% Discrimination Features for Face Recognition, Informatica (Vilnius), vol.
% 20, no. 1, pp. 115-138, 2009.
% 
% 
% The BibTex entries for the papers are here
% 
% @Article{ACKNOWL1,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "The Complete Gabor-Fisher Classifier for Robust Face Recognition",
%     journal = "EURASIP Advances in Signal Processing",
%     volume = "2010",
%     pages = "26",
%     year = "2010",
% }
% 
% @Article{ACKNOWL2,
%     author = "Vitomir \v{S}truc and Nikola Pave\v{s}i\'{c}",
%     title  = "Gabor-Based Kernel Partial-Least-Squares Discrimination Features for Face Recognition",
%     journal = "Informatica (Vilnius)",
%     volume = "20",
%     number = "1",
%     pages = "115–138",
%     year = "2009",
% }
% 
% Official website:
% If you have down-loaded the toolbox from any other location than the
% official website, plese check the following link to make sure that you
% have the most recent version:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/PhDface/index.html
%
% 
% OTHER TOOLBOXES 
% If you are interested in face recognition you are invited to have a look
% at the INface toolbox as well. It contains implementations of several
% state-of-the-art photometric normalization techniques that can further 
% improve the face recognition performance, especcially in difficult 
% illumination conditions. The toolbox is available from:
% 
% http://luks.fe.uni-lj.si/sl/osebje/vitomir/face_tools/INFace/index.html
% 
%
% Copyright (c) 2011 Vitomir Štruc
% Faculty of Electrical Engineering,
% University of Ljubljana, Slovenia
% http://luks.fe.uni-lj.si/en/staff/vitomir/index.html
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files, to deal
% in the Software without restriction, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
% 
% December 2011

function [rec_rates, ranks] = produce_CMC_PhD(results)
%% Dummies
rec_rates=[];
ranks= [];

%% Check inputs

%check number of inputs
if nargin <1
    disp('Wrong number of input parameters! The function requires at least one input argument.')
    return;
elseif nargin >1
    disp('Wrong number of input parameters! The function requires no more than one input argument.')
    return;
elseif nargin==1 
    decision_mode = 'ID';
end
decision_mode = 'ID';

%check for mode
    if isfield(results,'mode') ~= 1
        disp('The results structure contains no definition for "mode". Missing results.mode!');
        return;
    end


    %check which mode was used
    if strcmp(results.mode,'sep')==1
       if isfield(results,'dist')~=1
           disp('The specification about the employed distance could not be found. Missing results.dist!')
           return;
       end

       if isfield(results,'dim')~=1
           disp('The specification about the employed feature-dimensionality could not be found. Missing results.dim!')
           return;
       end

       if isfield(results,'client_dist')~=1
           disp('Could not find the client distances. Missing results.client_dist!')
           return;
       end

       if isfield(results,'same_cli_id')~=1
           disp('Could not find the Id info. Missing results.same_cli_id!')
           return;
       end

       if isfield(results,'client_horizontal_ids')~=1
           disp('Could not find client ID info. Missing results.client_horizontal_ids!')
           return;
       end

       if isfield(results,'client_vertical_ids')~=1
           disp('Could not find the client ID info. Missing results.client_vertical_ids!')
           return;
       end

       if isfield(results,'imp_dist')~=1
           disp('Could not find the impostor distances. Missing results.imp_dist!')
           return;
       end

       if isfield(results,'same_imp_id')~=1
           disp('Could not find the impostor ID info. Missing results.same_imp_id!')
           return;
       end

       if isfield(results,'imp_vertical_ids')~=1
           disp('Could not find the impostor ID info. Missing results.imp_vertical_ids!')
           return;
       end

       if isfield(results,'imp_horizontal_ids')~=1
           disp('Could not find the impostor ID info. Missing results.imp_horizontal_ids!')
           return;
       end


    elseif strcmp(results.mode,'all')==1
%         if nargin == 3
%             disp('The second input structure with results can be used only in the separation mode!')
%             return;
%         end

        if isfield(results,'dist')~=1
           disp('The specification about the employed distance could not be found. Missing results.dist!')
           return;
       end

       if isfield(results,'dim')~=1
           disp('The specification about the employed feature-dimensionality could not be found. Missing results.dim!')
           return;
       end

%        if isfield(results,'same_id')~=1
%            disp('Could not find the ID info. Missing results.same_id!')
%            return;
%        end

       if isfield(results,'dist')~=1
           disp('Could not find the similarity matrix. Missing results.same_id!')
           return;
       end

       if isfield(results,'horizontal_ids')~=1
           disp('Could not find the ID info. Missing results.horizontal_ids!')
           return;
       end

       if isfield(results,'vertical_ids')~=1
           disp('Could not find the ID info. Missing results.vertical_ids!')
           return;
       end
    else
        disp('The input "mode" was not recognized as a valid mode!')
        return;
    end
    
    if strcmp(decision_mode,'ID')==1 || strcmp(decision_mode,'image')==1
        %ok
    else
        disp('The decision mode has to be a valid string identifier. Swithing to defaults: (ID)')
        decision_mode='ID';
    end

%% Compute the CMC - main part

if strcmp(results.mode,'sep')==1
    if strcmp(decision_mode,'ID')==1
        
        %get unique target IDs
        unique_cli_id = unique(results.client_horizontal_ids);
        
        %get query IDs
        unique_quer_id = unique(results.client_vertical_ids);
        
        %each query image has to have a match in the target set - check
        for i=1:length(unique_quer_id);
           if sum(sum(find(unique_quer_id(i)==unique_cli_id)))==0
               disp('At least one of the query images does not have a target ID in the target set! Terminating.')
               return;
           end  
        end
        
        %produce ID based similarity matrix - IDs are horizontal
        ID_distances = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        true_IDs = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        for i=1:length(results.client_vertical_ids)
            for j=1:length(unique_cli_id)
                [x,y]=find(unique_cli_id(j)==results.client_horizontal_ids);
                
                %compute median distance for each ID
                ID_distances(i,j) = median(results.client_dist(i,y));
                if results.client_vertical_ids(i)==unique_cli_id(j)
                    true_IDs(i,j)=1;
                end
            end
        end
        
        %generate CMC
        max_rank = length(unique_cli_id);
        
        %possible ranks
        ranks = 1:max_rank;
        
        %sort the rows
        ID_distances_sort = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        true_IDs_sort = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        for i=1:length(results.client_vertical_ids)
            [ID_distances_sort(i,:), ind] = sort(ID_distances(i,:));
            true_IDs_sort(i,:) =  true_IDs(i,ind);
        end
        
        %iterate through ranks
        rec_rates = zeros(1,max_rank);
        tmp = 0;
        for i=1:max_rank
            tmp = tmp + sum(true_IDs_sort(:,i));
            rec_rates(1,i)=tmp/length(results.client_vertical_ids);
        end  
    elseif strcmp(decision_mode,'image')==1
        %the only differnce here is that I do not produce a matching score
        %based on the median but with the min function
        
        %get unique target IDs
        unique_cli_id = unique(results.client_horizontal_ids);
        
        %get query IDs
        unique_quer_id = unique(results.client_vertical_ids);
        
        %each query image has to have a match in the target set - check
        for i=1:length(unique_quer_id);
           if sum(sum(find(unique_quer_id(i)==unique_cli_id)))==0
               disp('At least one of the query images does not have a target ID in the target set! Terminating.')
               return;
           end  
        end
        
        %produce ID based similarity matrix - IDs are horizontal
        ID_distances = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        true_IDs = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        for i=1:length(results.client_vertical_ids)
            for j=1:length(unique_cli_id)
                [x,y]=find(unique_cli_id(j)==results.client_horizontal_ids);
                
                %compute minimum distance for each ID
                ID_distances(i,j) = min(results.client_dist(i,y));
                if results.client_vertical_ids(i)==unique_cli_id(j)
                    true_IDs(i,j)=1;
                end
            end
        end
        
        %generate CMC
        max_rank = length(unique_cli_id);
        
        %possible ranks
        ranks = 1:max_rank;
        
        %sort the rows
        ID_distances_sort = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        true_IDs_sort = zeros(length(results.client_vertical_ids),length(unique_cli_id));
        for i=1:length(results.client_vertical_ids)
            [ID_distances_sort(i,:), ind] = sort(ID_distances(i,:));
            true_IDs_sort(i,:) =  true_IDs(i,ind);
        end
        
        %iterate through ranks
        rec_rates = zeros(1,max_rank);
        tmp = 0;
        for i=1:max_rank
            tmp = tmp + sum(true_IDs_sort(:,i));
            rec_rates(1,i)=tmp/length(results.client_vertical_ids);
        end  
        
        
    else
        disp('The entered decision mode was not recognizied as a valid mode!')
        return;
    end   
elseif strcmp(results.mode,'all')==1
    if strcmp(decision_mode,'ID')==1
        
        %get unique target IDs
        unique_cli_id = unique(results.horizontal_ids);
        
        %get query IDs
        unique_quer_id = unique(results.vertical_ids);
        
        %each query image has to have a match in the target set - check
        split_flag = 0;
        for i=1:length(unique_quer_id);
           if sum(sum(find(unique_quer_id(i)==unique_cli_id)))==0
               disp('At least one of the query images does not have a target ID in the target set! Considering only query IDs with matching target IDs.')
               split_flag = 1;
           end  
        end

        %exclude all query images without matching IDs in the target set
        if split_flag==1
            %get the common IDs - common to target and query images
            common_IDs = intersect(unique_cli_id,unique_quer_id);
            
            %determine the number of valid query IDs
            number_vertical_IDs = 0;
            for i=1:length(common_IDs)
                number_vertical_IDs = number_vertical_IDs+length(find(common_IDs(i)==results.vertical_ids));
            end
            
            %build new similarity matrix
            sym_matrix = zeros(number_vertical_IDs,length(results.horizontal_ids));
            same_ids = zeros(number_vertical_IDs,length(results.horizontal_ids));
            new_vertical_IDs = zeros(1,number_vertical_IDs);
            cont=1;
            for i=1:length(common_IDs)
                ind = find(common_IDs(i)==results.vertical_ids);
                sym_matrix(cont:cont+length(ind)-1,:)=results.match_dist(ind,:);
                same_ids(cont:cont+length(ind)-1,:)=results.same_cli_id(ind,:);
                new_vertical_IDs(1,cont:cont+length(ind)-1)=results.vertical_ids(1,ind);
                cont = cont+length(ind);
            end
            
            %save new parameter value into the results structure
            results.match_dist = sym_matrix;
            results.same_id = same_ids;
            results.vertical_ids = new_vertical_IDs;
            
        end
        
        %produce ID based similarity matrix - IDs are horizontal
        ID_distances = zeros(length(results.vertical_ids),length(unique_cli_id));
        true_IDs = zeros(length(results.vertical_ids),length(unique_cli_id));
        for i=1:length(results.vertical_ids)
            for j=1:length(unique_cli_id)
                [x,y]=find(unique_cli_id(j)==results.horizontal_ids);
                
                %compute median distance for each ID
                ID_distances(i,j) = median(results.match_dist(i,y));
                if results.vertical_ids(i)==unique_cli_id(j)
                    true_IDs(i,j)=1;
                end
            end
        end
        
        %generate CMC
        max_rank = length(unique_cli_id);
        
        %possible ranks
        ranks = 1:max_rank;
        
        %sort the rows
        ID_distances_sort = zeros(length(results.vertical_ids),length(unique_cli_id));
        true_IDs_sort = zeros(length(results.vertical_ids),length(unique_cli_id));
        for i=1:length(results.vertical_ids)
            [ID_distances_sort(i,:), ind] = sort(ID_distances(i,:));
            true_IDs_sort(i,:) =  true_IDs(i,ind);
        end
        
        %iterate through ranks
        rec_rates = zeros(1,max_rank);
        tmp = 0;
        for i=1:max_rank
            tmp = tmp + sum(true_IDs_sort(:,i));
            rec_rates(1,i)=tmp/length(results.vertical_ids);
        end  
    elseif strcmp(decision_mode,'image')==1
        %the only differnce here is that I do not produce a matching score
        %based on the median but with the min function
        
        %get unique target IDs
        unique_cli_id = unique(results.horizontal_ids);
        
        %get query IDs
        unique_quer_id = unique(results.vertical_ids);
        
        %each query image has to have a match in the target set - check
        split_flag = 0;
        for i=1:length(unique_quer_id);
           if sum(sum(find(unique_quer_id(i)==unique_cli_id)))==0
               disp('At least one of the query images does not have a target ID in the target set! Considering only query IDs with matching target IDs.')
               split_flag = 1;
           end  
        end

        %exclude all query images without matching IDs in the target set
        if split_flag==1
            %get the common IDs - common to target and query images
            common_IDs = intersect(unique_cli_id,unique_quer_id);
            
            %determine the number of valid query IDs
            number_vertical_IDs = 0;
            for i=1:length(common_IDs)
                number_vertical_IDs = number_vertical_IDs+length(find(common_IDs(i)==results.vertical_ids));
            end
            
            %build new similarity matrix
            sym_matrix = zeros(number_vertical_IDs,length(results.horizontal_ids));
            same_ids = zeros(number_vertical_IDs,length(results.horizontal_ids));
            new_vertical_IDs = zeros(1,number_vertical_IDs);
            cont=1;
            for i=1:length(common_IDs)
                ind = find(common_IDs(i)==results.vertical_ids);
                sym_matrix(cont:cont+length(ind)-1,:)=results.match_dist(ind,:);
                same_ids(cont:cont+length(ind)-1,:)=results.same_cli_id(ind,:);
                new_vertical_IDs(1,cont:cont+length(ind)-1)=results.vertical_ids(1,ind);
                cont = cont+length(ind);
            end
            
            %save new parameter value into the results structure
            results.match_dist = sym_matrix;
            results.same_id = same_ids;
            results.vertical_ids = new_vertical_IDs;
            
        end
        
        %produce ID based similarity matrix - IDs are horizontal
        ID_distances = zeros(length(results.vertical_ids),length(unique_cli_id));
        true_IDs = zeros(length(results.vertical_ids),length(unique_cli_id));
        for i=1:length(results.vertical_ids)
            for j=1:length(unique_cli_id)
                [x,y]=find(unique_cli_id(j)==results.horizontal_ids);
                
                %compute median distance for each ID
                ID_distances(i,j) = min(results.match_dist(i,y));
                if results.vertical_ids(i)==unique_cli_id(j)
                    true_IDs(i,j)=1;
                end
            end
        end
        
        %generate CMC
        max_rank = length(unique_cli_id);
        
        %possible ranks
        ranks = 1:max_rank;
        
        %sort the rows
        ID_distances_sort = zeros(length(results.vertical_ids),length(unique_cli_id));
        true_IDs_sort = zeros(length(results.vertical_ids),length(unique_cli_id));
        for i=1:length(results.vertical_ids)
            [ID_distances_sort(i,:), ind] = sort(ID_distances(i,:));
            true_IDs_sort(i,:) =  true_IDs(i,ind);
        end
        
        %iterate through ranks
        rec_rates = zeros(1,max_rank);
        tmp = 0;
        for i=1:max_rank
            tmp = tmp + sum(true_IDs_sort(:,i));
            rec_rates(1,i)=tmp/length(results.vertical_ids);
        end  
        
        
    else
        disp('The entered decision mode was not recognizied as a valid mode!')
        return;
    end   
    
end



















































