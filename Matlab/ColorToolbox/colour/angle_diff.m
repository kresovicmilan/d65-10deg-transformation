function anglediff = angle_diff(col1,col2)
%ANGLE_DIFF Calculates angular difference between two hue angles
%
% col1 or col2 can be a vector of values with which the other value is compared
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

anglediff=abs(col1-col2);
t=find(anglediff>180);
anglediff(t)=360-anglediff(t);
