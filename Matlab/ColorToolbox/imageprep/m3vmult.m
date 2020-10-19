function output=m3vmult(M,data)

% M3VMULT Performs matrix multiplication on a 3x3 matrix and 
% each row of a nx3 vector.
%
% Assumes input data is in columns
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

if ischar(data)
   ABC=dlmread(data,'\t');
elseif isnumeric(data)
   ABC=data;
else
   error('No valid input data to m3vmult')
end

output=(M*ABC')';



