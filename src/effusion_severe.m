% Parameters for the model
sigmaX_1 = 10; % Adjust based on the severity level
sigmaY_1 = 2;
sigmaZ_1 = 3;
centerCoordinates = [125, 250, 82]; % Adjust these coordinates based on the target area in the DHP

% Size of the 3D array
xSize = 265; 
ySize = 490;
zSize = 305;


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
effusionModel_1 = exp(-((x-centerCoordinates(1)).^2 / (2*sigmaX_1^2) + (y-centerCoordinates(2)).^2 / (2*sigmaY_1^2) + (z-centerCoordinates(3)).^2 / (2*sigmaZ_1^2)));


% Parameters for the model
sigmaX_2 = 7; % Adjust based on the severity level
sigmaY_2 = 7;
sigmaZ_2 = 1;
centerCoordinates = [191, 223, 82]; % Adjust these coordinates based on the target area in the DHP


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
effusionModel_2 = exp(-((x-centerCoordinates(1)).^2 / (2*sigmaX_2^2) + (y-centerCoordinates(2)).^2 / (2*sigmaY_2^2) + (z-centerCoordinates(3)).^2 / (2*sigmaZ_2^2)));




% Insert the effusion into the DHP
% Assuming effusion model intensity needs to be normalized or scaled according to the DHP
peakIntensity1 = 60;
peakIntensity2 = 34;
effusionModel_1 = effusionModel_1 * peakIntensity1;
effusionModel_2 = effusionModel_2 * peakIntensity2;

% Step 1: Identify White Matter in the Original DHP
whiteMatterMask = DHP_3D == 2;  % Binary mask where white matter exists

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value (17) to the white matter

% Step 3: Overlay the Enhanced White Matter on Top of the Lesion Model
% Combine the lesion model with enhanced white matter (without modifying original DHP)
DHP_eff_severe = DHP_3D + effusionModel_1 + effusionModel_2; % Original DHP + Lesion Model
DHP_eff_severe(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Overlay brighter white m


% Set the constant z value
zconstant = 82; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP_eff_severe, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP_eff_severe(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));