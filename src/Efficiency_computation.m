% Efficiency Analysis for 12 Individual Scripts
num_scripts = 11;
num_iterations = 20;

% Preallocate arrays
time_data = zeros(num_scripts, num_iterations);


script_names = {'mild effusion', 'moderate effusion' 'severe effusion'... 
    'mild edema', 'moderate edema', 'severe edema'...
    'mild microhaemmorhage', 'moderate microhaemmorhage', 'severe microhaemmorhage'...
    'mild superficial siderosis', 'moderate superficial siderosis'};

for script_idx = 1:num_scripts
    fprintf('Running script: %s\n', script_names{script_idx});

    for iter = 1:num_iterations
        

        % Start timing
        tic;
    
        %%%%% Execute your script here based on script_idx %%%%%
        switch script_idx
            
            case 1
       % Parameters for the model

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
blackRegionMask = DHP_3D == 1;      % cortical regions with pixel value 1

% Step 2: Create a Copy of the White Matter with Higher Intensity for Visualization
enhancedWhiteMatter = whiteMatterMask * 17;  % Assign a brighter pixel value (17) to the white matter

% Step 3: Overlay the Enhanced White Matter on Top of the Lesion Model
% Combine the lesion model with enhanced white matter (without modifying original DHP)
DHP_eff_mild = DHP_3D;
DHP_eff_mild(blackRegionMask) = effusionModel(blackRegionMask);  % Apply lesions only in black areas
DHP_eff_mild(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Overlay brighter white matter
        

    case 2
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

            case 3
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

            case 4
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
            case 5
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

            case 6
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

            case 7
% Define the DHP dimensions (Ensure this matches your DHP dataset)
xSize = 265; 
ySize = 490;
zSize = 305;

% Initialize a 3D meshgrid
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);

% Define hemorrhage lesion parameters (3 Lesions)
lesionCenters = [
    68, 218, 77;  % Lesion 1 (Example coordinates)
    73, 221, 77;  % Lesion 2
    67, 222, 77   % Lesion 3
];

% Elliptical lesion dimensions
sigmaX = [1, 2, 1];  % Adjusted to form elliptical lesions
sigmaY = [2, 1, 1];
sigmaZ = [1, 1, 1];

% Create an empty 3D lesion model
hemorrhageModel = zeros(ySize, xSize, zSize);

% Generate microhemorrhage lesions at specified locations
for i = 1:size(lesionCenters, 1)
    cx = lesionCenters(i,1);
    cy = lesionCenters(i,2);
    cz = lesionCenters(i,3);
    
    % Elliptical lesion mask
    lesionMask = exp(-((x-cx).^2 / (2*sigmaX(i)^2) + (y-cy).^2 / (2*sigmaY(i)^2) + (z-cz).^2 / (2*sigmaZ(i)^2)));

    % Apply threshold to create a hard boundary (binary mask)
    lesionMask = lesionMask > 0.5;  

    % Assign a low pixel intensity (hypointense appearance)
    hemorrhageModel(lesionMask) = 5;  % Darker pixel intensity for microhemorrhages
end


% Step 1: Create Masks for White Matter and Cerebral Cortex
whiteMatterMask = (DHP_3D == 2);   % White Matter Mask
cortexMask = (DHP_3D == 1);        % Cerebral Cortex Mask

% Step 2: Assign Pixel Values for Visualization
enhancedWhiteMatter = whiteMatterMask * 22; % Adjust White Matter Pixel Value
enhancedCortex = cortexMask * 44 ;           % Adjust Cortex Pixel Value

% Step 3: Overlay Hemorrhage Lesions (ONLY Overwriting White Matter)
DHP_micro_mild = DHP_3D; % Start with the original DHP
DHP_micro_mild(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Preserve White Matter
DHP_micro_mild(cortexMask) = enhancedCortex(cortexMask);  % Preserve Cortex

% Overwrite lesion areas in white matter with a low intensity
lesionRegion = hemorrhageModel > 0;  % Boolean mask of hemorrhage locations
DHP_micro_mild(lesionRegion & whiteMatterMask) = hemorrhageModel(lesionRegion & whiteMatterMask); 

            case 8
% Define the DHP dimensions (Ensure this matches your DHP dataset)
xSize = 265; 
ySize = 490;
zSize = 305;

% Initialize a 3D meshgrid
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);

% Define hemorrhage lesion parameters (3 Lesions with Elliptical Shape)
lesionCenters = [
    133, 212, 60;  % Lesion 1 (Example coordinates)
    136, 213, 60;  % Lesion 2
    130, 201, 60   % Lesion 3
];

% Elliptical lesion dimensions
sigmaX = [1, 1, 2];  % Adjusted to form elliptical lesions
sigmaY = [2, 1, 3];
sigmaZ = [3, 2, 3];

% Create an empty 3D lesion model
hemorrhageModel = zeros(ySize, xSize, zSize);

% Generate microhemorrhage lesions at specified locations
for i = 1:size(lesionCenters, 1)
    cx = lesionCenters(i,1);
    cy = lesionCenters(i,2);
    cz = lesionCenters(i,3);
    
    % Elliptical lesion mask
    lesionMask = exp(-((x-cx).^2 / (2*sigmaX(i)^2) + (y-cy).^2 / (2*sigmaY(i)^2) + (z-cz).^2 / (2*sigmaZ(i)^2)));

    % Apply threshold to create a hard boundary (binary mask)
    lesionMask = lesionMask > 0.5;  

    % Assign a low pixel intensity (hypointense appearance)
    hemorrhageModel(lesionMask) = 5;  % Darker pixel intensity for microhemorrhages
end

% Step 1: Create Masks for White Matter and Cerebral Cortex
whiteMatterMask = (DHP_3D == 2);   % White Matter Mask
cortexMask = (DHP_3D == 1);        % Cerebral Cortex Mask

% Step 2: Assign Pixel Values for Visualization
enhancedWhiteMatter = whiteMatterMask * 22; % Adjust White Matter Pixel Value
enhancedCortex = cortexMask * 44;           % Adjust Cortex Pixel Value

% Step 3: Overlay Hemorrhage Lesions (ONLY Overwriting White Matter)
DHP_micro_moderate = DHP_3D; % Start with the original DHP
DHP_micro_moderate(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Preserve White Matter
DHP_micro_moderate(cortexMask) = enhancedCortex(cortexMask);  % Preserve Cortex

% Overwrite lesion areas in white matter with a low intensity
lesionRegion = hemorrhageModel > 0;  % Boolean mask of hemorrhage locations
DHP_micro_moderate(lesionRegion & whiteMatterMask) = hemorrhageModel(lesionRegion & whiteMatterMask); 

            case 9
% Define the DHP dimensions (Ensure this matches your DHP dataset)
xSize = 265; 
ySize = 490;
zSize = 305;

% Initialize a 3D meshgrid
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);

% Define hemorrhage lesion parameters (3 Lesions with Elliptical Shape)
lesionCenters = [
    80, 257, 87;  % Lesion 1 (Example coordinates)
    80, 262, 87;  % Lesion 1 (Example coordinates)
    115, 276, 87;  % Lesion 2
    95, 276, 87   % Lesion 3
];

% Elliptical lesion dimensions
sigmaX = [1.5, 1.5, 1.5, 1.5];  % Adjusted to form elliptical lesions
sigmaY = [1.5, 1.5, 1.5, 1.5];
sigmaZ = [1, 1, 1, 1];

% Create an empty 3D lesion model
hemorrhageModel = zeros(ySize, xSize, zSize);

% Generate microhemorrhage lesions at specified locations
for i = 1:size(lesionCenters, 1)
    cx = lesionCenters(i,1);
    cy = lesionCenters(i,2);
    cz = lesionCenters(i,3);
    
    % Elliptical lesion mask
    lesionMask = exp(-((x-cx).^2 / (2*sigmaX(i)^2) + (y-cy).^2 / (2*sigmaY(i)^2) + (z-cz).^2 / (2*sigmaZ(i)^2)));

    % Apply threshold to create a hard boundary (binary mask)
    lesionMask = lesionMask > 0.5;  

    % Assign a low pixel intensity (hypointense appearance)
    hemorrhageModel(lesionMask) = 5;  % Darker pixel intensity for microhemorrhages
end

% Step 1: Create Masks for White Matter and Cerebral Cortex
whiteMatterMask = (DHP_3D == 2);   % White Matter Mask
cortexMask = (DHP_3D == 1);        % Cerebral Cortex Mask

% Step 2: Assign Pixel Values for Visualization
enhancedWhiteMatter = whiteMatterMask * 22; % Adjust White Matter Pixel Value
enhancedCortex = cortexMask * 44;           % Adjust Cortex Pixel Value

% Step 3: Overlay Hemorrhage Lesions (ONLY Overwriting White Matter)
DHP_micro_severe = DHP_3D; % Start with the original DHP
DHP_micro_severe(whiteMatterMask) = enhancedWhiteMatter(whiteMatterMask);  % Preserve White Matter
DHP_micro_severe(cortexMask) = enhancedCortex(cortexMask);  % Preserve Cortex

% Overwrite lesion areas in white matter with a low intensity
lesionRegion = hemorrhageModel > 0;  % Boolean mask of hemorrhage locations
DHP_micro_severe(lesionRegion & whiteMatterMask) = hemorrhageModel(lesionRegion & whiteMatterMask); 
            case 10
% Define the DHP dimensions
xSize = 265; 
ySize = 490;
zSize = 305;

% Initialize Meshgrid
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);

% Define Microhemorrhage Lesion Parameters (Overwriting White Matter)
sigmaX_H1 = 1.5; sigmaY_H1 = 1.5; sigmaZ_H1 = 1;
centerH1 = [193, 277, 101]; % Lesion in White Matter
centerH2 = [203, 273, 101]; % Lesion in White Matter

% Define Superficial Siderosis Lesion Parameters (Overwriting Cortex)
sigmaX_S1 = 6; sigmaY_S1 = 15; sigmaZ_S1 = 1;
centerS1 = [140, 300, 101]; % Lesion in Cerebral Cortex
centerS2 = [173, 292, 101]; % Lesion in Cerebral Cortex

% Generate Microhemorrhage Lesions (STRICT Hypointense Spots)
hemorrhageModel_1 = exp(-((x-centerH1(1)).^2 / (2*sigmaX_H1^2) + (y-centerH1(2)).^2 / (2*sigmaY_H1^2) + (z-centerH1(3)).^2 / (2*sigmaZ_H1^2))) > 0.6;
hemorrhageModel_2 = exp(-((x-centerH2(1)).^2 / (2*sigmaX_H1^2) + (y-centerH2(2)).^2 / (2*sigmaY_H1^2) + (z-centerH2(3)).^2 / (2*sigmaZ_H1^2))) > 0.6;

% Generate Superficial Siderosis Lesions (STRICT Hypointense Spots)
siderosisModel_1 = exp(-((x-centerS1(1)).^2 / (2*sigmaX_S1^2) + (y-centerS1(2)).^2 / (2*sigmaY_S1^2) + (z-centerS1(3)).^2 / (2*sigmaZ_S1^2))) > 0.6;
siderosisModel_2 = exp(-((x-centerS2(1)).^2 / (2*sigmaX_S1^2) + (y-centerS2(2)).^2 / (2*sigmaY_S1^2) + (z-centerS2(3)).^2 / (2*sigmaZ_S1^2))) > 0.6;

% Set Lesion Intensity (Darker Appearance)
lesionIntensity = 5;
hemorrhageModel_1 = hemorrhageModel_1 * lesionIntensity;
hemorrhageModel_2 = hemorrhageModel_2 * lesionIntensity;
siderosisModel_1 = siderosisModel_1 * lesionIntensity;
siderosisModel_2 = siderosisModel_2 * lesionIntensity;

% Step 1: Create Masks for White Matter and Cerebral Cortex
whiteMatterMask = (DHP_3D == 2);   % White Matter Mask
cortexMask = (DHP_3D == 1);        % Cerebral Cortex Mask

% Step 2: Preserve Original White Matter and Cortex Intensities
DHP_sid_mild = DHP_3D;  % Start with original DHP

% Apply White Matter Mask (Fixed Intensity)
DHP_sid_mild(whiteMatterMask) = 34;  

% Apply Cortex Mask (Fixed Intensity)
DHP_sid_mild(cortexMask) = 65;  

% Step 3: Overlay Microhemorrhages (ONLY Overwriting White Matter)
DHP_sid_mild(whiteMatterMask & hemorrhageModel_1) = lesionIntensity;
DHP_sid_mild(whiteMatterMask & hemorrhageModel_2) = lesionIntensity;

% Step 4: Overlay Superficial Siderosis (ONLY Overwriting Cerebral Cortex)
DHP_sid_mild(cortexMask & siderosisModel_1) = lesionIntensity;
DHP_sid_mild(cortexMask & siderosisModel_2) = lesionIntensity;

            case 11
% Define the DHP dimensions
xSize = 265; 
ySize = 490;
zSize = 305;

% Initialize Meshgrid
[x, y, z] = meshgrid(1:xSize, 1:ySize, 1:zSize);

% Define Microhemorrhage Lesion Parameters (Overwriting White Matter)
sigmaX_H1 = 1.2; sigmaY_H1 = 1.2; sigmaZ_H1 = 1;
centerH1 = [87, 220, 53]; % Lesion in White Matter


% Define Superficial Siderosis Lesion Parameters (Overwriting Cortex)
sigmaX_S1 = 20; sigmaY_S1 = 10; sigmaZ_S1 = 1;
centerS1 = [90, 265, 53]; % Lesion in Cerebral Cortex
centerS2 = [100, 273, 53]; % Lesion in Cerebral Cortex

% Generate Microhemorrhage Lesions (STRICT Hypointense Spots)
hemorrhageModel_1 = exp(-((x-centerH1(1)).^2 / (2*sigmaX_H1^2) + (y-centerH1(2)).^2 / (2*sigmaY_H1^2) + (z-centerH1(3)).^2 / (2*sigmaZ_H1^2))) > 0.6;


% Generate Superficial Siderosis Lesions (STRICT Hypointense Spots)
siderosisModel_1 = exp(-((x-centerS1(1)).^2 / (2*sigmaX_S1^2) + (y-centerS1(2)).^2 / (2*sigmaY_S1^2) + (z-centerS1(3)).^2 / (2*sigmaZ_S1^2))) > 0.6;
siderosisModel_2 = exp(-((x-centerS2(1)).^2 / (2*sigmaX_S1^2) + (y-centerS2(2)).^2 / (2*sigmaY_S1^2) + (z-centerS2(3)).^2 / (2*sigmaZ_S1^2))) > 0.6;

% Set Lesion Intensity (Darker Appearance)
lesionIntensity = 5;
hemorrhageModel_1 = hemorrhageModel_1 * lesionIntensity;
siderosisModel_1 = siderosisModel_1 * lesionIntensity;
siderosisModel_2 = siderosisModel_2 * lesionIntensity;

% Step 1: Create Masks for White Matter and Cerebral Cortex
whiteMatterMask = (DHP_3D == 2);   % White Matter Mask
cortexMask = (DHP_3D == 1);        % Cerebral Cortex Mask

% Step 2: Preserve Original White Matter and Cortex Intensities
DHP_sid_moderate = DHP_3D;  % Start with original DHP

% Apply White Matter Mask (Fixed Intensity)
DHP_sid_moderate(whiteMatterMask) = 34;  

% Apply Cortex Mask (Fixed Intensity)
DHP_sid_moderate(cortexMask) = 65;  

% Step 3: Overlay Microhemorrhages (ONLY Overwriting White Matter)
DHP_sid_moderate(whiteMatterMask & hemorrhageModel_1) = lesionIntensity;


% Step 4: Overlay Superficial Siderosis (ONLY Overwriting Cerebral Cortex)
DHP_sid_moderate(cortexMask & siderosisModel_1) = lesionIntensity;
DHP_sid_moderate(cortexMask & siderosisModel_2) = lesionIntensity;
        end
        %%%%% Script execution ends here %%%%%
        
        % Record execution time
        time_data(script_idx, iter) = toc;  
end

end
% Compute mean and std deviation of execution time
mean_times = mean(time_data, 2);
std_times = std(time_data, 0, 2);



% Plot Execution Time with Error Bars
figure;
bar(mean_times, 'FaceColor',[0.3,0.7,0.9]); hold on;
errorbar(1:num_scripts, mean_times, std_times, 'k.', 'LineWidth',1.5);
title('Mean Execution Time per Script');
ylabel('Execution Time (s)');
xticks(1:num_scripts);
xticklabels(script_names);
xtickangle(45);
grid on;


