function Lab=lch2lab(LCh)
% LCH2LAB: Converts polar LCh data to Cartesian CIELAB
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

r=(pi/180);
L=LCh(:,1);
C=LCh(:,2);
h=LCh(:,3);

a=cos(r*h).*C;
b=sin(r*h).*C;

Lab=[L,a,b];