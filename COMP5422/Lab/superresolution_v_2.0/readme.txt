SUPERRESOLUTION - v2.0
v1.0 - January 12, 2006 by Patrick Vandewalle, Patrick Zbinden 
       and Cecilia Perez
v2.0 - November 13, 2006 by Patrick Vandewalle, Karim Krichane, 
       Cecilia Perez, and Patrick Zbinden

Matlab Graphical User Interface for Super-Resolution Imaging 
To run the application, run "superresolution" in Matlab (with the 
'application' directory as working directory)

This program allows a user to perform registration of a set of low
resolution input images and reconstruct a high resolution image from
them.  Multiple image registration and reconstruction methods have
been implemented. As input, the user can either select existing
images, or generate a set of simulated low resolution images from a
high resolution image.  More information is available online:
http://lcavwww.epfl.ch/software/superresolution

If you use this software for your research, please also put a
reference to the related paper "A Frequency Domain Approach to
Registration of Aliased Images with Application to Super-Resolution"
Patrick Vandewalle, Sabine Susstrunk and Martin Vetterli available at
http://lcavwww.epfl.ch/reproducible_research/VandewalleSV05/

Currently the following algorithms are implemented:
Image Registration
- D. Keren, S. Peleg, and R. Brada, Image sequence enhancement using 
  sub-pixel displacement, in Proceedings IEEE Conference on
  Computer Vision and Pattern Recognition, June 1988, pp. 742-746.
- L. Lucchese and G. M. Cortelazzo, A noise-robust frequency domain
  technique for estimating planar roto-translations, IEEE Transactions
  on Signal Processing, vol. 48, no. 6, pp. 1769-1786, June 2000.
- B. Marcel, M. Briot, and R. Murrieta, Calcul de Translation et 
  Rotation par la Transformation de Fourier, Traitement du Signal,
  vol. 14, no. 2, pp. 135-149, 1997.
- P. Vandewalle, S. Susstrunk and M. Vetterli, A Frequency Domain 
  Approach to Registration of Aliased Images with Application to 
  Super-Resolution, accepted to EURASIP Journal on Applied Signal 
  Processing (special issue on Super-resolution), 2005.

Image Reconstruction
- Interpolation: bicubic interpolation using Matlab's built-in 
  griddata function.
- Papoulis-Gerchberg: Papoulis and Gerchberg's POCS algorithm 
  projecting successively onto the space of known pixels and the space 
  of bandlimited images.
- Iterated Back Projection: an iterative back projection algorithm 
  inspired by M. Irani and S. Peleg, Improving resolution by image 
  registration, Graphical Models and Image Processing, 53:231-239, 1991.
- Robust Super Resolution: a more robust version of the iterative back-
  projection algorithm using a median instead of a mean, based on 
  A. Zomet, A. Rav-Acha, and S. Peleg, Robust Super-Resolution, 
  Proceedings international conference on computer vision and pattern 
  recognition (CVPR), 2001.
- POCS: a projection onto convex sets (POCS) algorithm
- Structure-Adaptive Normalized Convolution: algorithm implementing
  the method from Tuan Q. Pham, Lucas J. van Vliet and Klamer Schutte, 
  Robust Fusion of Irregularly Sampled Data Using Adaptive Normalized 
  Convolution, EURASIP Journal on Applied Signal Processing, Vol. 2006, 
  Article ID 83268, 12 pages, 2006.

-----------------------------------------------------------------------
Copyright (C) 2005-2007 Laboratory of Audiovisual Communications (LCAV), 
Ecole Polytechnique Federale de Lausanne (EPFL), 
CH-1015 Lausanne, Switzerland 

This program is free software; you can redistribute it and/or modify it 
under the terms of the GNU General Public License as published by the 
Free Software Foundation; either version 2 of the License, or (at your 
option) any later version. This software is distributed in the hope that 
it will be useful, but without any warranty; without even the implied 
warranty of merchantability or fitness for a particular purpose. 
See the GNU General Public License for more details 
(enclosed in the file GPL). 
