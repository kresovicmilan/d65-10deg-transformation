function Lab2=abs2rel(Lab,mwhite,illuminant)
%ABS2REL: Converts CIELAB values relative to a perfect diffuser to corresponding 
% values relative to media white.
%
% Example: Lab2 =abs2rel(Lab2,[96.42,100,82.49]);
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

if nargin>2
   rwhite=illuminant;
else
   rwhite=d(50);
end

XYZ=lab2xyz(Lab,rwhite);
Lab2=xyz2lab(XYZ,mwhite);
