%test file

fileid = fopen('temp.txt');
a = textscan(fileid, '%s');
fclose(fileid);

c = cell2mat(a{:});
c = c(:, 1:end-4);

t = c(1, :)

score = getmaxscore(t, c, 5);