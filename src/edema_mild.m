% Size of the 3D array
xSize = 265; 
ySize = 490;
zSize = 305;

% Parameters for the model

sigmaX_1 = 2; % Adjust based on the severity level
sigmaY_1 = 3;
sigmaZ_1 = 1;
centerCoordinates_1 = [204, 235, 92]; % Adjust these coordinates based on the target area in the DHP

% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_1 = exp(-((x-centerCoordinates_1(1)).^2 / (2*sigmaX_1^2) + (y-centerCoordinates_1(2)).^2 / (2*sigmaY_1^2) + (z-centerCoordinates_1(3)).^2 / (2*sigmaZ_1^2)));

% Parameters for the model

sigmaX_2 = 4; % Adjust based on the severity level
sigmaY_2 = 10;
sigmaZ_2 = 1;
centerCoordinates_2 = [204, 223, 92]; % Adjust these coordinates based on the target area in the DHP

% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_2 = exp(-((x-centerCoordinates_2(1)).^2 / (2*sigmaX_2^2) + (y-centerCoordinates_2(2)).^2 / (2*sigmaY_2^2) + (z-centerCoordinates_2(3)).^2 / (2*sigmaZ_2^2)));

% Parameters for the model

sigmaX_3 = 5; % Adjust based on the severity level
sigmaY_3 = 6;
sigmaZ_3 = 1;
centerCoordinates_3 = [198, 217, 92]; % Adjust these coordinates based on the target area in the DHP

% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
edemaModel_3 = exp(-((x-centerCoordinates_3(1)).^2 / (2*sigmaX_3^2) + (y-centerCoordinates_3(2)).^2 / (2*sigmaY_3^2) + (z-centerCoordinates_3(3)).^2 / (2*sigmaZ_3^2)));


% Insert the effusion into the DHP
% Assuming effusion model intensity needs to be normalized or scaled according to the DHP
peakIntensity_1 = 44;
peakIntensity_2 = 34;
peakIntensity_3 = 22;
edemaModel_1 = edemaModel_1 * peakIntensity_1;
edemaModel_2 = edemaModel_2 * peakIntensity_2;
edemaModel_3 = edemaModel_3 * peakIntensity_3;
% Step 1: Identify White Matter in the Original DHP
whiteMatterMask = DHP_3D == 2;  % Binary mask where white matter exists

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value (17) to the white matter

% Step 3: Apply Lesions Only to White Matter
lesionMask = whiteMatterMask;  % Lesions will only be applied where white matter exists
DHP_edema_mild = DHP_3D;  % Start with the original DHP

% Step 4: Reapply the Enhanced White Matter for Visualization
DHP_edema_mild(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Ensure white matter remains visible

DHP_edema_mild(lesionMask) = DHP_edema_mild(lesionMask) + edemaModel_1(lesionMask) + edemaModel_2(lesionMask) + edemaModel_3(lesionMask);  % Apply lesions to white matter

% Set the constant z value
zconstant = 92; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP_edema_mild, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP_edema_mild(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));