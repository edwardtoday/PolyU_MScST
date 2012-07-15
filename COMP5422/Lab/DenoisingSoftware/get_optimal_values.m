
% 
% This is the code to generate the figures in the paper for your own dataset
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sigma_r vs. sigma_d for a specific sigma_n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% Put the directory of your image data set
imgFiles = dir('.\thisisyourimagedirectory\*.jpg');

% Set the noise parameter 
sigma_n = 5;

% Initialize the 3D mean square error (mse) matrix
mse = zeros(10,10,length(imgFiles)); % (Number of sigma_r samples, number of sigma_d samples, number of images)

for k=1:length(imgFiles) % For all images

    k

    % Read the image, get the luminance component
    filename = imgFiles(k).name;
    input = imread(['.\thisisyourimagedirectory\',filename]);
    input = rgb2gray(input); input = double(input(:,:,1));

    y = 0;
    x = 0;
    for sigma_d = 1:1:10, % For all sigma_d
        y = y+1;
        x = 0;
        sigma_d
        for sigma_r = 2:2:20, % For all sigma_r
            x = x+1;
            % Add noise to input
            input_noisy = input + sigma_n*randn(size(input));

            % Denoise
            window_d = round(sigma_d*2);
            output = gen_bilateral1(input_noisy,sigma_d,sigma_r,window_d);

            % Get mse
            temp = output(:)-input(:);
            mse(x,y,k) = temp'*temp/length(temp);

        end
    end

end
total_mse = sum(mse,3);
%save mse.mat
figure; imagesc(total_mse);

% Display result with interpolation
[x,y] = meshgrid(1:1:10,2:2:20);
[xi,yi] = meshgrid(1:0.1:10,2:0.2:20,'bicubic');
msei = interp2(x,y,mse,xi,yi);
figure; imagesc([1:0.1:10],[2:0.2:20],msei); %CHANGE THE LIMITS OF LINSPACE
xlabel('\sigma_d');ylabel('\sigma_r');title('\sigma_n=5');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sigma_r vs. sigma_n for fixed sigma_d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc;

% Read images
imgFiles = dir('.\thisisyourimagedirectory\*.*');

% Set parameters
sigma_d = 5.0;
window_d = round(sigma_d*2);

% Initialize mse
mse = zeros(10,10,length(imgFiles));

for k=1:length(imgFiles) % For all images

    k

    % Read image, get luminance
    filename = imgFiles(k).name;
    input = imread(['.\thisisyourimagedirectory\',filename]);
    input = rgb2gray(input); input = double(input(:,:,1));

    y = 0;
    x = 0;
    range_sigma_n = 1:2:20;
    for sigma_n = range_sigma_n, % For all sigma_n
        y = y+1;
        x = 0;
        sigma_n

        range_sigma_r = [round(2*sigma_n)-20:round(2*sigma_n)+20]; % Set a limit to save for computational time
        for sigma_r = range_sigma_r, % For all sigma_r
            x = x+1;

            if sigma_r<1,
                mse(x,y,k) = NaN;
            else
                % Add noise to input
                input_noisy = input + sigma_n*randn(size(input));

                % Denoise
                output = gen_bilateral1(input_noisy,sigma_d,sigma_r,window_d);

                % Get mse
                temp = output(:)-input(:);
                mse(x,y,k) = temp'*temp/length(temp);
            end
        end
    end

end
% Get the portion of the mse, in case you use a larger matrix for
% initialization
mse2 = mse(1:x,1:y,1:k);
[Y,I] = min(mse2,[],1);
I2 = zeros(size(I));

% Get the optimal values, find their average and standard deviation
ind = 0;
for sigma_n = range_sigma_n,
    ind = ind+1;
    range_sigma_r = [round(2*sigma_n)-20:round(2*sigma_n)+20];
    [Y,I] = min(mse2,[],1);
    I2(:,ind,:) = range_sigma_r(I(:,ind,:)); 
end
  
ave_I = mean(I2,3);
std_I = std(I2,1,3);

%save mseoptimal.mat

% Display the result
sigmanrange = 1:y;
sigmarrange = 1:x;
figure; plot(range_sigma_n,ave_I,'.'); hold on;
for i = 1:length(ave_I),
    line([range_sigma_n(i),range_sigma_n(i)],[ave_I(i)+std_I(i),ave_I(i)-std_I(i)]);
end
% Line fit;
hold on;
a = (range_sigma_n*ave_I')/(range_sigma_n*range_sigma_n')
xx = linspace(0,max(range_sigma_n),200);
plot(xx,a*xx,'r');

