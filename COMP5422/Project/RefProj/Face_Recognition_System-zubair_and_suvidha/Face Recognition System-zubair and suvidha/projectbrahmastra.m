% Author name : Mohd Zubair Saifi and Suvidha Sadhu
% e mail id: saifi_zuber@yahoo.co.in or fizz.hey@gmail.com
% Submitted as a part of final year project
% Birla Vishwakarma Mahavidyalaya, VVNagar, Gujarat, India
% This is a face recognition system using Eigenface approach
% This is main execution program and with it two functional files namely 
% Eigenface_calculation.m and Recognition.m is necessary
% GUI has been made using simple display commands and input command





clc
disp('           Welcome to Face Recognition System- THE IDENTITY      ');
disp('               By Suvidha Sadhu and Mohd Zubair Saifi            ');
disp('*******************************************************************');
disp('                          Main Menu                       ');
disp('*******************************************************************');
disp('           Press various keys for the required operation           ');
disp('*******************************************************************');
disp('           Calculate Eigenfaces.............[1]');
disp('           Input Image for Recognition......[2]');
disp('           Update the database..............[3]');
disp('           Delete Database..................[4]');
disp('           To quit the program..............[Q]');
disp('           To quit without exiting matlab...[press any key except above]');
disp('*******************************************************************');
disp('*******************************************************************');
disp('        You need to calculate Eigenfaces before recognition        ');
disp('       Above statement is applicable only for the first image        ');
disp('If you have already calculated the eigenfaces then just kickstart with Recognition');
y=input('Press appropriate keys for required operation........', 's');
switch(y)
    case '1'
        imageno=input('Enter the no of data images with which you want to continue');
        [T, m1, Eigenfaces, ProjectedImages, imageno]=Eigenface_calculation(imageno);
        save Eigenface.mat;
        projectbrahmastra;
    case '2'
        load Eigenface.mat;
        outputimage=Recognition(T, m1, Eigenfaces, ProjectedImages, imageno);
        disp('Press any key to continue...............');
        pause;
        projectbrahmastra;
        
    case '3'
         load Eigenface.mat;
         global imageno;
         imageno=imageno+1;
         [filename pathname]=uigetfile('*.jpg', 'Select image for input');
         movefile(filename,strcat(int2str(imageno),'.jpg'));
         [T, m1, Eigenfaces, ProjectedImages, imageno]=Eigenface_calculation(imageno);
         save Eigenface.mat;
         projectbrahmastra;            
    case '4'
        g=input('Do you really want to delete the whole database..press Y for yes and N for no','s');
    switch(g)
        case 'y'
            delete Eigenface.mat;
            disp('The whole database of images is deleted');
            disp('Press any key to continue......')
            pause;
            projectbrahmastra;
        case 'Y'
            delete Eigenface.mat;
            disp('The whole database of images is deleted');
            disp('Press any key to continue......')
            pause;
            projectbrahmastra;
        case 'n'
            disp('You have decided not to delete the database');
            disp('Press any key to continue.......')
            pause;
            projectbrahmastra;
        case 'N'
            disp('You have decided not to delete the database');
            disp('Press any key to continue.......')
            pause;
            projectbrahmastra;
        otherwise
            disp('Invalid Entry');
            disp('Press any key to continue........');
            pause;
            projectbrahmastra;
    end
    case 'q'
        disp('Are you sure you want to quit');
        f=input('Press Y for yes or any other key for No','s');
        switch(f)
            case 'y'
                quit;
            case 'Y'
                quit;
            otherwise
                projectbrahmastra;
        end
    case 'Q'
        disp('Are you sure you want to quit');
        f=input('Press Y for yes or any other key for No','s');
        switch(f)
            case 'y'
                quit;
            case 'Y'
                quit;
            otherwise
                projectbrahmastra;
        end
    otherwise
        disp('We hope you enjoyed your journey with our Face Recognition System- THE IDENTITY');
          
 load test2.mat % this is used to test the values of variable
                % this is not a compulsory command
end

