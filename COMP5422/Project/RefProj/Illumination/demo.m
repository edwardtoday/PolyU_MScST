%X=imread('sample_image.bmp');
X=imread('1.pgm');
       Y = single_scale_retinex(X);
       figure,imshow(X);
       figure,imshow(Y,[]);
