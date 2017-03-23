function mat = file2array(pathname)
    %get data from a one string per line file
    % and put it into a char array

    fileid = fopen(pathname);
    a = textscan(fileid, '%s');
    fclose(fileid);

    mat = cell2mat(a{:});
    mat = mat(:, 1:end-4);
end