%get the database and the fnames
db = file2array('database.txt');
fnames = file2array('fnames.txt');

%get the correspondance between db and fnames
% corr = [fnameIndex, dbIndex, score] 
corr = getcorresp(fnames, db);

%remove the value rows with score 20
log = corr(corr(:, 3) ~= 20, :);

%% output a log file
%put the log in table format

%output the result in a text file

%output the result in a pdf file