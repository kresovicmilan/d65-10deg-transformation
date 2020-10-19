function [XYZ,Madapt]=iccbradford(XYZs,XYZws)
%ICCBRADFORD: Linear Bradford chromatic adaptation transform calculates 
%tristimulus values under ICC PCS D50 adapting field.
%
%Algorithm according to ISO 15076-1:2010 Annex E.3
%
%Example: XYZ=iccbradford(XYZs,XYZws)
%
%The subscript ws denotes the tristimulus values of the 
%source white under source conditions and reference white under
%reference conditions respectively; and the subscript s denotes the 
%tristimulus values of the colour being transformed.
%
%[XYZ,chad]=iccbradford(XYZs,XYZws) also returns the chromatic adaptation
%matrix that must be encoded in an ICC profile if the source data is not
%D50
%
%   Colour Engineering Toolbox
%   author:	© Phil Green
%   version:	1.1
%   date:	21-02-2017
%   book:	http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:    http://www.digitalcolour.org



Mbfd=[0.8951,0.2664,-0.1614;-0.7502,1.7135,0.0367;0.0389,-0.0685,1.0296];
Minv=inv(Mbfd);

% Calculate nCIEXYZ values of PCS adopted white and source adopted white
XYZw=[96.42  100.00   82.49]/100;
XYZnaw=XYZws/100;

% Calculate ratios of source and PCS adopted white points
RGBsrc=Mbfd*XYZnaw';
RGBpcs=Mbfd*XYZw';
M=diag(RGBpcs./RGBsrc);
Madapt=Minv*M*Mbfd;

% Calculate corresponding chromatically adapted XYZ values
XYZ=(Madapt*XYZs')';
