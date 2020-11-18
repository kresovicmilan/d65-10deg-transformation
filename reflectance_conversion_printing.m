function [XYZ, LAB] = reflectance_conversion_printing(filename, col)
addpath(genpath('Matlab\MatlabColorTool'));

transformed_file_path = '4TestChartSpectral\';
folder_storage_path = '5TestImagesAndColorimetry\';
FID = fopen(strcat(transformed_file_path, filename));
data = textscan(FID,'%s');
fclose(FID);
stringData = string(data{:});
stringArray = [stringData(find(stringData=='BEGIN_DATA') + 1: end - 1)];
reshapeArr = reshape(stringArray', 41, [])';
reflectance = str2double([reshapeArr(:, 6:end)]);

XYZ = r2xyz(reflectance, 380, 730, col); %d50_31, a_31

if strcmp('d50_31',col)
    wp = [96.42 100 82.49];
elseif strcmp('d65_64',col)
    wp = [94.811 100 107.304];
end

LAB = xyz2lab(XYZ, col, wp); %'d50_31'

combined = horzcat(XYZ, LAB);

dlmwrite(strcat(folder_storage_path, 'test_chart_', col, '.txt'),combined,'delimiter','\t','newline','pc');

addpath(genpath('Matlab\ColorToolbox'));
L = LAB(:, 1);
ab = LAB(:, 2:3);
L=L/100;
ab = (ab+128)/255;
lab=[L, ab];
imagedata = v2m(lab, [42,50]);
imwrite(imagedata, strcat(folder_storage_path, 'test_chart_', col, '.tif'));

end