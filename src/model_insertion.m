% Parameters for the model
severityLevel = 2; % Change as needed: 1 for mild, 2 for moderate, 3 for severe
sigma = 7; % Adjust based on the severity level
centerCoordinates = [100, 290, 95]; % Adjust these coordinates based on the target area in the DHP

% Size of the 3D array
xSize = 265; 
ySize = 490;
zSize = 305;


% Generate a 3D Gaussian blob at the specified location
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);
effusionModel = exp(-((x-centerCoordinates(1)).^2 + (y-centerCoordinates(2)).^2 + (z-centerCoordinates(3)).^2)/(2*sigma^2));

% Insert the effusion into the DHP
% Assuming effusion model intensity needs to be normalized or scaled according to the DHP
peakIntensity = 60;
effusionModel = effusionModel * peakIntensity;

% Step 1: Identify White Matter in the Original DHP
whiteMatterMask = DHP_3D == 2;  % Binary mask where white matter exists
blackRegionMask = DHP_3D == 1;      % Black regions with pixel value 1

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value (17) to the white matter

% Step 3: Overlay the Enhanced White Matter on Top of the Lesion Model
% Combine the lesion model with enhanced white matter (without modifying original DHP)
DHP = DHP_3D;
DHP(blackRegionMask) = effusionModel(blackRegionMask);  % Apply lesions only in black areas
DHP(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Overlay brighter white matter


% Set the constant z value
zconstant = 95; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));

% Assume generatedModel is a 3D matrix: rows x cols x slices
specificSlice = DHP(:,:,zconstant);

% Save the specific z slice as a PGM file
imwrite(specificSlice, "C:\Uni_stuff\Individual_project\ARIA-E Images\Effusion\effusion_mild_model.pgm");