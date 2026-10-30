function writePGM(filename, img)
    img = uint8(img);
    [rows, cols] = size(img);
    maxVal = max(img(:)); % detect actual maximum
    fid = fopen(filename, 'w');
    fprintf(fid, 'P2\n%d %d\n%d\n', cols, rows, maxVal); % write actual max
    for i = 1:rows
        fprintf(fid, '%d ', img(i,:));
        fprintf(fid, '\n');
    end
    fclose(fid);
end

