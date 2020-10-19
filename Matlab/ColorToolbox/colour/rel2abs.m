function Lab=rel2abs(Lab,mwhite,illuminant)
%REL2ABS: Converts CIELAB values relative to a perfect diffuser to corresponding 
% values relative to media white.
%
% Example: Lab2 =rel2abs(Lab2,[96.42,100,82.49]);
%
%   Colour Engineering Toolbox
%   author:    � Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

if nargin>2
   rwhite=illuminant;
else
   rwhite=D(50);
end

XYZ=lab2xyz(Lab,mwhite);
Lab=xyz2lab(XYZ,rwhite);
