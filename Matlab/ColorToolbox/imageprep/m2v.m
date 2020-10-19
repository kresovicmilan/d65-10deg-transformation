function V = m2v(data)
% M2V: Converts rxcxn matrix of colour data to n columns. 
% The order of the data in the resulting columns is r1,r2,...rn
%
% Example: M2V(CMY) where CMY is a 3D matrix 
% arranged row x column x colour.
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

% Input matrix and get size
LMN=data;
[r,c,n]=size(LMN);

% Prepare empty matrix
V=zeros(r*c,n);

% Transpose and reshape to vectors
for i=1:n
   L=LMN(:,:,i);
   Lt=L';
   V(:,i)=Lt(:);
end
