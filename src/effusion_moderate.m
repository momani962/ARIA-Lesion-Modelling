% Parameters for the model
sigmaX_1 = 13; % Adjust based on the severity level
sigmaY_1 = 15;
sigmaZ_1 = 2;
centerCoordinates = [172, 307, 82]; % Adjust these coordinates based on the target area in the DHP

% Size of the 3D array
xSize = 265; 
ySize = 490;
zSize = 305;


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
effusionModel_1 = exp(-((x-centerCoordinates(1)).^2 / (2*sigmaX_1^2) + (y-centerCoordinates(2)).^2 / (2*sigmaY_1^2) + (z-centerCoordinates(3)).^2 / (2*sigmaZ_1^2)));


% Insert the effusion into the DHP
% Assuming effusion model intensity needs to be normalized or scaled according to the DHP
peakIntensity = 60;
effusionModel_1 = effusionModel_1 * peakIntensity;



% Step 1: Identify White Matter and Black Regions in the Original DHP
whiteMatterMask = DHP_3D == 2;      % White matter with pixel value 2
blackRegionMask = DHP_3D == 1;      % Black regions with pixel value 1

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value to the white matter

% Step 3: Apply Lesions Only to Black Regions
DHP_eff_moderate = DHP_3D;  % Start with the original DHP
DHP_eff_moderate(blackRegionMask) = effusionModel_1(blackRegionMask);  % Apply lesions only in black areas

% Step 4: Reapply the Enhanced White Matter on Top
DHP_eff_moderate(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Overlay brighter white matter


% Set the constant z value
zconstant = 82; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP_eff_moderate, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP_eff_moderate(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));