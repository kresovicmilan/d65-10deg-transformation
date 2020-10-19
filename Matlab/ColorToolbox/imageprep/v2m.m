function M=v2m(V,array_size)
% V2M: Converts data arranged in 1D columns to 2D arrays; the array 
% dimensions are taken from 'array_size' and the number of columns 
% becomes the number of planes in the 3rd dimension.
%
% Inverts the conversion from arrays to columns performed by M2V.
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   29-12-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

r=array_size(1);
c=array_size(2);
[vr,vc]=size(V);

%check to see if there are the correct number of entries in V
if vr~=r*c
   disp('Error in array size')
   return
end

%Prepare empty matrices
M=zeros(r,c,vc);

%Reshape columns and transpose
for i=1:vc
   Vm=V(:,i);
   Mt=reshape(Vm,c,r);
   M(:,:,i)=Mt';
end
