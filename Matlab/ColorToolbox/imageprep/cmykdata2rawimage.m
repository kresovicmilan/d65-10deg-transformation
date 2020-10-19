function x=cmykdata2rawimage(data,filename)
% CMYKDATA2RAWIMAGE: Writes CMYK image data to Raw format image file.
%
% This function is useful when CMYK image data is to be saved to file, since Matlab does 
% not support CMYK data in the imwrite function.
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   7-11-2006
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

c=size(data,2);

if c~=4
   error('the number of channels is incorrect for CMYK colour space')
end
   

fid=fopen(filename,'wb');
x=fwrite(fid,data,'uint8');
status=fclose(fid);
if status<0
    error('Could not close file')
end
 