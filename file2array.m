function mat = file2array(pathname)
    %get data from a one string per line file
    % and put it into a char array

    fileid = fopen(pathname);
    mat = textscan(fileid, '%s');
    fclose(fileid);
end