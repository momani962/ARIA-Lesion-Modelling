





% Set the constant z value
zconstant = 95; % example value

% Check that zconstant is within the image dimensions
if zconstant > size(DHP_3D, 3)
    error('The constant z value is out of the image dimension bounds.');
end

% Extract the plane at z = zconstant
extracted_plane_z = squeeze(DHP_3D(:, :, zconstant));

% Display the extracted plane
figure;
imshow(extracted_plane_z, []);
title(sprintf('Extracted Plane at z = %d', zconstant));