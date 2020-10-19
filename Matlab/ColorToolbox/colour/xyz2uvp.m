function uvp=xyz2uvp(XYZ)
% XYZ2UVP: calculates CIE 1976 u',v' coordinates from tristimulus XYZ
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

X=XYZ(:,1);Y=XYZ(:,2);Z=XYZ(:,3);
up=4*X./(X+15*Y+3*Z);
vp=9*Y./(X+15*Y+3*Z);
uvp=[up,vp];