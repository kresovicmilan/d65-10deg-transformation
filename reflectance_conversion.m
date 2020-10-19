function [XYZ, LAB_not_scaled] = reflectance_conversion(filename, ill, obs, test_chart, printer_name)
addpath(genpath('Matlab\MatlabColorTool'));

transformed_file_path = '1TransformedFiles\';
FID = fopen(strcat(transformed_file_path, filename));
data = textscan(FID,'%s');
fclose(FID);
stringData = string(data{:});
stringArray = [stringData(find(stringData=='BEGIN_DATA') + 1: end - 1)];
reshapeArr = reshape(stringArray', 43, [])';
reflectance = str2double([reshapeArr(:, 3:end)]);

XYZ = r2xyz(reflectance, 380, 780, ill); %d50_31, a_31
folder_storage_path = '2CalculatedXYZLAB\';
%red XYZ
%RXYZ = XYZ(217, :);

%green XYZ
%GXYZ = XYZ(9, :);

%blue XYZ
%BXYZ = XYZ(505, :);

%X white point
%X_w = RXYZ(1) + GXYZ(1) + BXYZ(1);

%Y white point
%Y_w = RXYZ(2) + GXYZ(2) + BXYZ(2);

%Z white point
%Z_w = RXYZ(3) + GXYZ(3) + BXYZ(3);

%XYZ scaled to wp
%XYZ_scaled = XYZ * 100 / Y_w;

%X, Y, Z white point scaled
%X_w_scaled = X_w * 100 / Y_w;
%Y_w_scaled = Y_w * 100 / Y_w;
%Z_w_scaled = Z_w * 100 / Y_w;

%LAB scaled
%LAB_scaled = xyz2lab(XYZ_scaled, obs, [X_w_scaled, Y_w_scaled, Z_w_scaled]);

if strcmp('tc918_rgb',test_chart)
    wp = [XYZ(729, 1), XYZ(729, 2), XYZ(729, 3)];
elseif strcmp('eci2002v_cmyk', test_chart)
    wp = [XYZ(27, 1), XYZ(27, 2), XYZ(27, 3)];
elseif strcmp('eci2002r_cmyk', test_chart)
    wp = [XYZ(33, 1), XYZ(33, 2), XYZ(33, 3)];
end

%LAB not scaled
LAB_not_scaled = xyz2lab(XYZ, obs, wp); %'d50_31'

combined = horzcat(XYZ, LAB_not_scaled);

%fileID = fopen(strcat(folder_storage_path, printer_name, '_',test_chart, '_',datestr(now,'yyyy_dd_mm_HH_MM'), '.txt'),'w');
dlmwrite(strcat(folder_storage_path, printer_name, '_',test_chart, '_', obs,'.txt'),combined,'delimiter','\t','newline','pc');
%fprintf(fileID,'%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\n',combined);
%fclose(fileID);

addpath(genpath('Matlab\ColorToolbox'));
end