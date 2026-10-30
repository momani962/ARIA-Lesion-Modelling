% Parameters for the model

sigmaX_1 = 2; % Adjust based on the severity level
sigmaY_1 = 1;
sigmaZ_1 = 2;
centerCoordinates1 = [190, 272, 77]; % Adjust these coordinates based on the target area in the DHP

% Size of the 3D array
xSize = 265; 
ySize = 490;
zSize = 305;


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_1 = exp(-((x-centerCoordinates1(1)).^2 / (2*sigmaX_1^2) + (y-centerCoordinates1(2)).^2 / (2*sigmaY_1^2) + (z-centerCoordinates1(3)).^2 / (2*sigmaZ_1^2)));


% Parameters for the model

sigmaX_2 = 3; % Adjust based on the severity level
sigmaY_2 = 4;
sigmaZ_2 = 2;
centerCoordinates2 = [90, 269, 77]; % Adjust these coordinates based on the target area in the DHP


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_2 = exp(-((x-centerCoordinates2(1)).^2 / (2*sigmaX_2^2) + (y-centerCoordinates2(2)).^2 / (2*sigmaY_2^2) + (z-centerCoordinates2(3)).^2 / (2*sigmaZ_2^2)));

% Parameters for the model

sigmaX_3 = 2; % Adjust based on the severity level
sigmaY_3 = 4;
sigmaZ_3 = 2;
centerCoordinates3 = [81, 211, 77]; % Adjust these coordinates based on the target area in the DHP


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_3 = exp(-((x-centerCoordinates3(1)).^2 / (2*sigmaX_3^2) + (y-centerCoordinates3(2)).^2 / (2*sigmaY_3^2) + (z-centerCoordinates3(3)).^2 / (2*sigmaZ_3^2)));


sigmaX_4 = 4; % Adjust based on the severity level
sigmaY_4 = 3;
sigmaZ_4 = 3;
centerCoordinates4 = [85, 272, 77]; % Adjust these coordinates based on the target area in the DHP


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_4 = exp(-((x-centerCoordinates4(1)).^2 / (2*sigmaX_4^2) + (y-centerCoordinates4(2)).^2 / (2*sigmaY_4^2) + (z-centerCoordinates4(3)).^2 / (2*sigmaZ_4^2)));


% Parameters for the model

sigmaX_5 = 6; % Adjust based on the severity level
sigmaY_5 = 6;
sigmaZ_5 = 5;
centerCoordinates5 = [76, 212, 77]; % Adjust these coordinates based on the target area in the DHP


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_5 = exp(-((x-centerCoordinates5(1)).^2 / (2*sigmaX_5^2) + (y-centerCoordinates5(2)).^2 / (2*sigmaY_5^2) + (z-centerCoordinates5(3)).^2 / (2*sigmaZ_5^2)));

% Insert the effusion into the DHP
% Assuming effusion model intensity needs to be normalized or scaled according to the DHP
peakIntensity1 = 60;
peakIntensity2 = 22;
peakIntensity3 = 50;
peakIntensity4 = 22;
edemaModel_1 = edemaModel_1 * peakIntensity1;
edemaModel_2 = edemaModel_2 * peakIntensity2;
edemaModel_3 = edemaModel_3 * peakIntensity3;
edemaModel_4 = edemaModel_4 * peakIntensity4;
edemaModel_5 = edemaModel_5 * peakIntensity4;

% Step 1: Identify White Matter in the Original DHP
whiteMatterMask = DHP_3D == 2;  % Binary mask where white matter exists

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value (17) to the white matter

% Step 3: Apply Lesions Only to White Matter
lesionMask = whiteMatterMask;  % Lesions will only be applied where white matter exists
DHP_edema_moderate = DHP_3D;  % Start with the original DHP

% Step 4: Reapply the Enhanced White Matter for Visualization
DHP_edema_moderate(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Ensure white matter remains visible

DHP_edema_moderate(lesionMask) = DHP_edema_moderate(lesionMask) + edemaModel_1(lesionMask) + edemaModel_2(lesionMask) + edemaModel_3(lesionMask) + edemaModel_4(lesionMask) + edemaModel_5(lesionMask);  % Apply lesions to white matter




% Set the constant z value
zconstant = 77; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP_edema_moderate, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP_edema_moderate(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));



