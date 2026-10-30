
% Parameters for the model
sigmaX_1 = 22; % Extend along X-axis
sigmaY_1 = 8; % Moderate spread along Y-axis
sigmaZ_1 = 5;  % Thin spread along Z-axis
centerCoordinates1 = [117, 275, 57];

sigmaX_2 = 30; 
sigmaY_2 = 8;
sigmaZ_2 = 5;
centerCoordinates2 = [165, 285, 57];

sigmaX_3 = 15; 
sigmaY_3 = 6;
sigmaZ_3 = 5;
centerCoordinates3 = [105, 270, 57];

sigmaX_4 = 8; 
sigmaY_4 = 15;
sigmaZ_4 = 5;
centerCoordinates4 = [130, 285, 57];

sigmaX_5 = 3; 
sigmaY_5 = 6;
sigmaZ_5 = 5;
centerCoordinates5 = [110, 285, 57];

sigmaX_6 = 9; 
sigmaY_6 = 5;
sigmaZ_6 = 5;
centerCoordinates6 = [82, 260, 57];


xSize = 265; 
ySize = 490;
zSize = 305;

[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_1 = exp(-((x-centerCoordinates1(1)).^2/(2*sigmaX_1^2) + (y-centerCoordinates1(2)).^2/(2*sigmaY_1^2) + (z-centerCoordinates1(3)).^2/(2*sigmaZ_1^2)));
edemaModel_2 = exp(-((x-centerCoordinates2(1)).^2/(2*sigmaX_2^2) + (y-centerCoordinates2(2)).^2/(2*sigmaY_2^2) + (z-centerCoordinates2(3)).^2/(2*sigmaZ_2^2)));
edemaModel_3 = exp(-((x-centerCoordinates3(1)).^2/(2*sigmaX_3^2) + (y-centerCoordinates3(2)).^2/(2*sigmaY_3^2) + (z-centerCoordinates3(3)).^2/(2*sigmaX_3^2)));
edemaModel_4 = exp(-((x-centerCoordinates4(1)).^2/(2*sigmaX_4^2) + (y-centerCoordinates4(2)).^2/(2*sigmaY_4^2) + (z-centerCoordinates4(3)).^2/(2*sigmaX_4^2)));
edemaModel_5 = exp(-((x-centerCoordinates5(1)).^2/(2*sigmaX_5^2) + (y-centerCoordinates5(2)).^2/(2*sigmaY_5^2) + (z-centerCoordinates5(3)).^2/(2*sigmaX_5^2)));
edemaModel_6 = exp(-((x-centerCoordinates6(1)).^2/(2*sigmaX_6^2) + (y-centerCoordinates6(2)).^2/(2*sigmaY_6^2) + (z-centerCoordinates6(3)).^2/(2*sigmaX_6^2)));


peakIntensity = 100;
edemaModel_1 = edemaModel_1 * peakIntensity;
edemaModel_2 = edemaModel_2 * peakIntensity;
edemaModel_3 = edemaModel_3 * peakIntensity;
edemaModel_4 = edemaModel_4 * peakIntensity;
edemaModel_5 = edemaModel_5 * peakIntensity;
edemaModel_6 = edemaModel_6 * peakIntensity;

whiteMatterMask = DHP_3D == 2; 
blackRegionMask = DHP_3D == 1;      % Black regions with pixel value 1

enhancedWhiteMatter = whiteMatterMask * 17;

DHP_edema_severe = DHP_3D;

DHP_edema_severe(blackRegionMask) = edemaModel_1(blackRegionMask) + edemaModel_2(blackRegionMask);


DHP_edema_severe(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);

DHP_edema_severe(whiteMatterMask) = DHP_edema_severe(whiteMatterMask) + edemaModel_3(whiteMatterMask) + edemaModel_4(whiteMatterMask) + edemaModel_5(whiteMatterMask) + edemaModel_6(whiteMatterMask);

figure;
zconstant = 57;
extracted_plane_z = squeeze(DHP_edema_severe(:, :, zconstant));
imshow(extracted_plane_z, 'DisplayRange', [min(DHP_3D(:)), max(DHP_3D(:))]);


