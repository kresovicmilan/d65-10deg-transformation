function Lab=labimread(filename)
% LABIMREAD: Reads an 8-bit RGB TIFF file and interprets data as CIELAB L*, a*, b*.
% The image data is offset and scaled so that it is interpreted as 8-bit CIELAB 
% after saving with a photometric interpretation of RGB.
% N.B. Saving a CIELAB image as RGB tiff can be done in Adobe Photoshop by doing 
% Image..Mode..Multichannel and then Image..Mode..RGB before saving as tiff
%
% Calls MatLab function imread.m to read uint8 tiff image.
% For help on the use of imread, including supported data types,
% type 'help imread'
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2003
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

image=double(imread(filename));
Lab=zeros(size(image));

% offset and scale
Lab(:,:,1)=image(:,:,1)*100/255;
Lab(:,:,2)=image(:,:,2)-128;
Lab(:,:,3)=image(:,:,3)-128;

