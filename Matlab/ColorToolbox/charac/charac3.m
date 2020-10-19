function ABC = charac3(data1,data2)
% CHARAC3 Third order polynomial regression to find coefficient 
% matrix ABC for transforming between any two colour spaces.
%
% Example: charac('device.dat','xyz.dat') where 'device.dat','xyz.dat' 
% are tab-delimited ASCII files containing device data and XYZ 
% measurement data, arranged in columns.
%
%   Colour Engineering Toolbox
%   author:    © Phil Green
%   version:   1.1
%   date:  	   17-01-2001
%   book:      http://www.wileyeurope.com/WileyCDA/WileyTitle/productCd-0471486884.html
%   web:       http://www.digitalcolour.org

%Form regression matrix
C1=data2(:,1);
C2=data2(:,2);
C3=data2(:,3);

RC=polymat3(data1);
RCt=RC';

%Perform least-squares regression
A=(RC*RCt)\(RC*C1);
B=(RC*RCt)\(RC*C2);
C=(RC*RCt)\(RC*C3);
ABC=[A,B,C];
