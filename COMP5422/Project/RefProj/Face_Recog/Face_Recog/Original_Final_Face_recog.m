% Please enter the options as asked. This requires the MIT-OCL and Yale
% database of images. However for testing, a custom database of 9 images
% named from c1.jpg to c9.jpg can be used to test this code. Please update
% the path in line 154 after adding the code. After that run the code and
% provide the options as desired. This uses 2 types of features for the
% purposes of recognition namely Eigenfaces and the full face itself. This
% uses the concept of L1 norm minimization to identify the face from test
% images. Code by Neeraj Pai 29045615 UFL.
lv = 0;
while(lv ~= 1)
	clear all;
	clc;
    display('This program tests the efficiency of Face recognition using Sparse representation');
    display('Enter 1 to test on MIT-OCL database');
    display('Enter 2 to test on Yale Database');
    display('Enter 3 to test on custom database');
    in = input('Enter your option-');
    if ( (in ~= 1) && (in ~= 2) && (in ~= 3))
        display('Invalid option,quitting');
        break;
    end
    display('Enter 1 to test with Eigenfaces algorithm,2 for no features')
    ty = input('Enter your option-');
    if ( (ty ~= 1) && (ty ~= 2))
        display('Invalid option,quitting');
        break;
    end
    if (in ~= 3)
        display('Enter 1 for 1 test image per person, 3 for 3 test images');
        num_test = input('Enter your option-');
        if ( (num_test ~= 1) && (num_test ~= 3))
            display('Invalid option,quitting');
            break;
        end
    else
        num_test = 1;
    end
    display('Enter 1 to test for a single image, 2 to test entire database');
    tst = input('Enter your option-');
    if ( (tst ~= 1) && (tst ~= 2))
        display('Invalid option,quitting');
        break;
    end
    if (tst == 2)
        display('This may take some time, hold onto something');
    else
        switch(in)
            case 1;
                in_img = input('Enter image no from 1 to 400-');
                if ( (in_img < 1) && (in_img > 400))
                    display('Invalid option,quitting');
                    break;
                end
            case 2
                in_img = input('Enter template no from 1 to 38-');
                if ( (in_img < 1) && (in_img > 38))
                    display('Invalid option,quitting');
                    break;
                end
                in_img_no = input('Enter img no from 2 to 65-');
                if ( (in_img < 2) && (in_img > 65))
                    display('Invalid option,quitting');
                    break;
                end
            case 3
                in_img = input('Enter image no from 1 to 8-');
                if ( (in_img < 1) && (in_img > 8))
                    display('Invalid option,quitting');
                    break;
                end
        end     
	end
	%Training
    switch(in)
        case 1;
			r=112;
			c=92;
			rec=zeros(1,400);
			nrec=zeros(1,400);
			addpath('C:\Users\Neeraj\Desktop\Final Project\All_faces');
			if(num_test == 1)%1 training img 
				addpath('C:\Users\Neeraj\Desktop\Final Project\Single_face_basis');				
				M=40;
				%Finding Basis
				A=[];
				for i=1:M
					img=strcat('mainface',int2str(i),'.bmp');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
				end
			else %3 training img
				addpath('C:\Users\Neeraj\Desktop\Final Project\Three_face_basis');
				M=120;			
				%Finding Basis
				A=[];
				for i=1:M
					img=strcat('mainface',int2str(i),'.bmp');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
				end
			end		
		case 2;
			r=192;
			c=168;
			rec=zeros(1,2432);
			nrec=zeros(1,2432);
			addpath('C:\Users\Neeraj\Desktop\Final Project\Yale');
			if(num_test == 1)%1 training img 
				M=38;
				%Finding Basis
				A=[];
				for i=1:M
					img=strcat(int2str(i),'_33.jpg');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
				end
			else %3 training img
				M=38;			
				%Finding Basis
				A=[];
				for i=1:M
					img=strcat(int2str(i),'_33.jpg');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
					img=strcat(int2str(i),'_5.jpg');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
					img=strcat(int2str(i),'_47.jpg');
					a=imread(img);
					b=double(a);
					g=reshape(b,r*c,1);
					h=double(g);
					A=[A h];
				end
				M = 38*3;
			end					
		case 3;
			M=3;	
			r=640;
			c=480;
			rec=zeros(1,9);
			nrec=zeros(1,9);			
			addpath('C:\Users\Neeraj\Desktop\Final Project\Custom');
			%Finding Basis
			A=[];
			img='c3.jpg';
			a=imread(img);
			b=double(a);
			g=reshape(b,r*c,1);
			h=double(g);
			A=[A h];
			img='c4.jpg';
			a=imread(img);
			b=double(a);
			g=reshape(b,r*c,1);
			h=double(g);
			A=[A h];
			img='c7.jpg';
			a=imread(img);
			b=double(a);
			g=reshape(b,r*c,1);
			h=double(g);
			A=[A h];
	end
	if (ty == 1)%Eigenfaces KLT
		%Covariance matrix C=A'A, L=AA'
		L=A'*(A);
		% vv are the eigenvector for L
		% dd are the eigenvalue for both L=dbx'*dbx and C=dbx*dbx';
		[vv dd]=eig(L);
		% Sort and eliminate those whose eigenvalue is zero
		v=[];
		d=[];
		for i=1:size(vv,2)
		if(dd(i,i)>1e-4)
		v=[v vv(:,i)];
		d=[d dd(i,i)];
		end
		end

		%sort, will return an ascending sequence
		[B index]=sort(d);
		ind=zeros(size(index));
		dtemp=zeros(size(index));
		vtemp=zeros(size(v));
		len=length(index);
		for i=1:len
		dtemp(i)=B(len+1-i);
		ind(i)=len+1-index(i);
		vtemp(:,ind(i))=v(:,i);
		end
		d=dtemp;
		v=vtemp;
		% 
		%Normalization of eigenvectors
		for i=1:size(v,2) %access each column
		kk=v(:,i);
		temp=sqrt(sum(kk.^2));
		v(:,i)=v(:,i)./temp;
		end

		%Eigenvectors of C matrix
		u=[];
		for i=1:size(v,2)
		temp=sqrt(d(i));
		u=[u (A*v(:,i))./temp];
		end

		%Normalization of eigenvectors
		for i=1:size(u,2)
		kk=u(:,i);
		temp=sqrt(sum(kk.^2));
		u(:,i)=u(:,i)./temp;
		end

		% Find the weight of each face in the training set
		omega = [];
		for h=1:size(A,2)
		WW=[]; 
		for i=1:size(u,2)
		t = u(:,i)'; 
		WeightOfImage = dot(t,A(:,h)');
		WW = [WW; WeightOfImage];
		end
		omega = [omega WW];
		end
	end
	
	if (tst == 1)%Test only 1 image
		if (ty == 1)%Eigenfaces
			switch(in)
				case 1;
					img1=strcat('face',int2str(in_img),'.bmp');
				case 2;
					img1=strcat(int2str(in_img),'_',int2str(in_img_no),'.jpg');
				case 3;
					img1=strcat('c',int2str(in_img),'.jpg');
			end
			InputImage = imread(img1);
			subplot (1,2,1)
			imshow(InputImage); 
			title('Input image')
			NormImage = reshape(InputImage,r*c,1); 

			p = [];
			aa=size(u,2);
			for i = 1:aa
			pare = dot(double(NormImage),u(:,i));
			p = [p; pare];
			end
			ReshapedImage = u(:,1:aa)*p; %m is the mean image, u is the eigenvector
			ReshapedImage = reshape(ReshapedImage,r,c);
			ReshapedImage = ReshapedImage';

			InImWeight = [];
			for i=1:size(u,2)
			t = u(:,i)';
			WeightOfInputImage = dot(t,double(NormImage'));
			InImWeight = [InImWeight; WeightOfInputImage];
			end

			% %%%%%%%%%%%%%%%%%%%%%%%%%%%%L1 Norm Minimization%%%%%%%%%%%%%%%%%%%%%%%%%
			x = omega \ InImWeight;
			if(num_test == 3)%3 training images
                switch(in)
                    case 1;
                        u = [];
                        for j=1:3:120
                            l=(x(j)+x(j+1)+x(j+2))/3;
                            u=[u l];
                        end  
                    case 2;
                        u = [];
                        for j=1:3:112
                            l=(x(j)+x(j+1)+x(j+2))/3;
                            u=[u l];
                        end 
                end  
				[m i] = max(u);
			else%1 training image
				[m i] = max(x);
			end
			switch(in)
				case 1;
           			if(num_test == 3)%3 training images
    					img2=strcat('mainface',int2str(3*i),'.bmp');
                    else
                        img2=strcat('mainface',int2str(i),'.bmp');
                    end
				case 2;
					img2=strcat(int2str(i),'_33.jpg');
				case 3;
					img2=strcat('c',int2str(3*i),'.jpg');
			end
			subplot (1,2,2)
			imshow(img2); 
			title('Identified image')
		else % No features
			switch(in)
				case 1;
					img1=strcat('face',int2str(in_img),'.bmp');
				case 2;
					img1=strcat(int2str(in_img),'_',int2str(in_img_no),'.jpg');
				case 3;
					img1=strcat('c',int2str(in_img),'.jpg');
			end
			InputImage = imread(img1);
			subplot (1,2,1)
			imshow(InputImage); 
			title('Input image')
			y = reshape(InputImage,r*c,1); 
			y = double(y);
			x = A \ y;
			if(num_test == 3)%3 training images
                switch(in)
                    case 1;
                        u = [];
                        for j=1:3:120
                            l=(x(j)+x(j+1)+x(j+2))/3;
                            u=[u l];
                        end  
                    case 2;
                        u = [];
                        for j=1:3:112
                            l=(x(j)+x(j+1)+x(j+2))/3;
                            u=[u l];
                        end 
                end				  
				[m i] = max(u);
			else%1 training image
				[m i] = max(x);
			end
			switch(in)
				case 1;
           			if(num_test == 3)%3 training images
    					img2=strcat('mainface',int2str(3*i),'.bmp');
                    else
                        img2=strcat('mainface',int2str(i),'.bmp');
                    end
				case 2;
					img2=strcat(int2str(i),'_33.jpg');
				case 3;
					img2=strcat('c',int2str(3*i),'.jpg');
			end
			subplot (1,2,2)
			imshow(img2); 
			title('Identified image')
		end
	else % Check all faces
		if (ty == 1)%Eigenfaces
			switch(in)
				case 1;
					for q = 1:400
						img1=strcat('face',int2str(q),'.bmp');
						InputImage = imread(img1);
						NormImage = reshape(InputImage,r*c,1); 

						p = [];
						aa=size(u,2);
						for i = 1:aa
						pare = dot(double(NormImage),u(:,i));
						p = [p; pare];
						end
						ReshapedImage = u(:,1:aa)*p; %m is the mean image, u is the eigenvector
						ReshapedImage = reshape(ReshapedImage,r,c);
						ReshapedImage = ReshapedImage';

						InImWeight = [];
						for i=1:size(u,2)
						t = u(:,i)';
						WeightOfInputImage = dot(t,double(NormImage'));
						InImWeight = [InImWeight; WeightOfInputImage];
						end

						% %%%%%%%%%%%%%%%%%%%%%%%%%%%%L1 Norm Minimization%%%%%%%%%%%%%%%%%%%%%%%%%
						x = omega \ InImWeight;
						if(num_test == 3)%3 training images
							u = [];
							for j=1:3:120
								l=(x(j)+x(j+1)+x(j+2))/3;
								u=[u l];
							end    
							[m i] = max(u);
						else%1 training image
							[m i] = max(x);
						end
						if i == ceil(q/10)
							rec(q) = 1;
						else
							nrec(q) = 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/4
				case 2;%Yale database
					ind = 1;
					for q = 1:38
						for p = 2:65
							img1=strcat(int2str(q),'_',int2str(p),'.jpg');
							InputImage = imread(img1);
							NormImage = reshape(InputImage,r*c,1); 

							p = [];
							aa=size(u,2);
							for i = 1:aa
							pare = dot(double(NormImage),u(:,i));
							p = [p; pare];
							end
							ReshapedImage = u(:,1:aa)*p; %m is the mean image, u is the eigenvector
							ReshapedImage = reshape(ReshapedImage,r,c);
							ReshapedImage = ReshapedImage';

							InImWeight = [];
							for i=1:size(u,2)
							t = u(:,i)';
							WeightOfInputImage = dot(t,double(NormImage'));
							InImWeight = [InImWeight; WeightOfInputImage];
							end

							% %%%%%%%%%%%%%%%%%%%%%%%%%%%%L1 Norm Minimization%%%%%%%%%%%%%%%%%%%%%%%%%
							x = omega \ InImWeight;
							if(num_test == 3)%3 training images
								u = [];
								for j=1:3:112
									l=(x(j)+x(j+1)+x(j+2))/3;
									u=[u l];
								end    
								[m i] = max(u);
							else%1 training image
								[m i] = max(x);
							end
							if i == q
								rec(ind) = 1;
							else
								nrec(ind) = 1;
							end
							ind = ind + 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/ind*100
				case 3;%Custom database
					for q = 1:9
						img1=strcat('c',int2str(q),'.jpg');
						InputImage = imread(img1);
						NormImage = reshape(InputImage,r*c,1); 

						p = [];
						aa=size(u,2);
						for i = 1:aa
						pare = dot(double(NormImage),u(:,i));
						p = [p; pare];
						end
						ReshapedImage = u(:,1:aa)*p; %m is the mean image, u is the eigenvector
						ReshapedImage = reshape(ReshapedImage,r,c);
						ReshapedImage = ReshapedImage';

						InImWeight = [];
						for i=1:size(u,2)
						t = u(:,i)';
						WeightOfInputImage = dot(t,double(NormImage'));
						InImWeight = [InImWeight; WeightOfInputImage];
						end

						% %%%%%%%%%%%%%%%%%%%%%%%%%%%%L1 Norm Minimization%%%%%%%%%%%%%%%%%%%%%%%%%
						x = omega \ InImWeight;
						[m i] = max(x);
						if i == ceil(q/3)
							rec(q) = 1;
						else
							nrec(q) = 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/9*100
			end
		else % No features			
			switch(in)
				case 1;
					for q = 1:400
						img1=strcat('face',int2str(q),'.bmp');
						InputImage = imread(img1);
						y = reshape(InputImage,r*c,1); 
						y = double(y);
						x = A \ y;						
						if(num_test == 3)%3 training images
							u = [];
							for j=1:3:120
								l=(x(j)+x(j+1)+x(j+2))/3;
								u=[u l];
							end    
							[m i] = max(u);
						else%1 training image
							[m i] = max(x);
						end
						if i == ceil(q/10)
							rec(q) = 1;
						else
							nrec(q) = 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/4
				case 2;%Yale database
					ind = 1;
					for q = 1:38
						for p = 2:65
							img1=strcat(int2str(q),'_',int2str(p),'.jpg');
							InputImage = imread(img1);
							y = reshape(InputImage,r*c,1); 
							y = double(y);
							x = A \ y;
							if(num_test == 3)%3 training images
								u = [];
								for j=1:3:112
									l=(x(j)+x(j+1)+x(j+2))/3;
									u=[u l];
								end    
								[m i] = max(u);
							else%1 training image
								[m i] = max(x);
							end
							if i == q
								rec(ind) = 1;
							else
								nrec(ind) = 1;
							end
							ind = ind + 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/ind*100
				case 3;%Custom database
					for q = 1:9
						img1=strcat('c',int2str(q),'.jpg');
						InputImage = imread(img1);
						y = reshape(InputImage,r*c,1); 
						y = double(y);
						x = A \ y;
						[m i] = max(x);
						if i == ceil(q/3)
							rec(q) = 1;
						else
							nrec(q) = 1;
						end
					end
					display('Success rate in percentage is-')
					sum(rec)/9*100
			end
		end
	end
    lv = input('Enter 1 to quit, anything else to continue-');
end