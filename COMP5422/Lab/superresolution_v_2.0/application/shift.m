function im2 = shift(im1,x1,y1)
% SHIFT - shift an image over a non-integer amount of pixels
%    im2 = shift(im1,x1,y1)
%    shift an image over X1 in horizontal direction and Y1 in vertical 
%    direction and set the added pixels to 0    

%% -----------------------------------------------------------------------
% SUPERRESOLUTION - Graphical User Interface for Super-Resolution Imaging
% Copyright (C) 2005-2007 Laboratory of Audiovisual Communications (LCAV), 
% Ecole Polytechnique Federale de Lausanne (EPFL), 
% CH-1015 Lausanne, Switzerland 
% 
% This program is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the 
% Free Software Foundation; either version 2 of the License, or (at your 
% option) any later version. This software is distributed in the hope that 
% it will be useful, but without any warranty; without even the implied 
% warranty of merchantability or fitness for a particular purpose. 
% See the GNU General Public License for more details 
% (enclosed in the file GPL). 
%
% Latest modifications: January 12, 2006, by Patrick Vandewalle

[y0,x0,z0]=size(im1);

x1int=floor(x1); x1dec=x1-x1int;
y1int=floor(y1); y1dec=y1-y1int;
im2=im1;

for z=1:z0
 if y1>=0   
   for y=-y0:-y1int-2
       im2(-y,:,z)=(1-y1dec)*im2(-y1int-y,:,z)+y1dec*im2(-y1int-y-1,:,z);
   end
   if y1int<y0
       im2(y1int+1,:,z)=(1-y1dec)*im2(1,:,z);
   end
   for y=max(-y1int,-y0):-1
       im2(-y,:,z)=zeros(1,x0);
   end
 else
   if y1dec==0
       y1dec=y1dec+1;
       y1int=y1int-1;
   end
   for y=1:y0+y1int
       im2(y,:,z)=y1dec*im2(-y1int+y-1,:,z)+(1-y1dec)*im2(-y1int+y,:,z);
   end
   if -y1int<=y0
       im2(y0+y1int+1,:,z)=y1dec*im2(y0,:,z);
   end
   for y=max(1,y0+y1int+2):y0
       im2(y,:,z)=zeros(1,x0);        
   end
 end
 if x1>=0   
   for x=-x0:-x1int-2
       im2(:,-x,z)=(1-x1dec)*im2(:,-x1int-x,z)+x1dec*im2(:,-x1int-x-1,z);
   end
   if x1int<x0
       im2(:,x1int+1,z)=(1-x1dec)*im2(:,1,z);
   end
   for x=max(-x1int,-x0):-1
       im2(:,-x,z)=zeros(y0,1);
   end
 else
   if x1dec==0
       x1dec=x1dec+1;
       x1int=x1int-1;
   end
   for x=1:x0+x1int
       im2(:,x,z)=x1dec*im2(:,-x1int+x-1,z)+(1-x1dec)*im2(:,-x1int+x,z);
   end
   if -x1int<=x0
       im2(:,x0+x1int+1,z)=x1dec*im2(:,x0,z);
   end
   for x=max(1,x0+x1int+2):x0
       im2(:,x,z)=zeros(y0,1);        
   end
 end
end

