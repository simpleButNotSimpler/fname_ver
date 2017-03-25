%% build the file names txt file
% create the 'fnames.txt' file
tic
dirpath = 'C:\Users\kkmlover\Documents\DJIMY\WORK\fname_ver\testim\';
list = dir('testim/*.bmp');
fn = {list.name};
fn = fn';
fn = cell2table(fn);
writetable(fn,'fnames.txt', 'WriteVariableNames', false);


%get the database and the fnames
db = file2array('database.txt');
fnames = file2array('fnames.txt');

%get the correspondance between db and fnames
% corr = [fnameIndex, dbIndex, score] 
endpoint = 6;
corr = getcorresp(fnames, db, endpoint);

%remove the value rows with score 20
log = corr(corr(:, 3) ~= 17, :);

%automatic correction
autocrt = log(log(:, 3) > 5, :);

%manual correction
manualcrt = log(log(:, 3) <= 5, :);

%% output a log file
% output the result in a text file
logheader = cell(1, 5);
logheader{1} = strcat('# of read files: ', num2str(length(list)));
logheader{2} = strcat('# of incorrect file names: ', num2str(size(log, 1)));
logheader{3} = strcat('# of correction attempted: ', num2str(size(log, 1)));
logheader{4} = strcat('# of correction succeeded: ', num2str(size(autocrt, 1)));
logheader{5} = strcat('# of correction failed: ', num2str(size(manualcrt, 1)));

%write to file
fileid = fopen('logFile.txt', 'w');
fprintf(fileid, '%s \r\n', logheader{:});

  %automatically corrected name
fprintf(fileid, '\r\n\r\n\t\t\t%s\r\n', 'sucessfull attempts');
fprintf(fileid, '%-24s  %-24s %-2s\r\n', 'erronous_names', 'corrected_names', 'score');
for t=1:size(autocrt, 1)
    oldname = fnames{1}{autocrt(t, 1), :};
    newname = db{1}{autocrt(t, 2), :};
    fprintf(fileid, '%24s  %24s %2d\r\n', oldname, newname, autocrt(t, 3));
    oldName_path = fullfile(dirpath, oldname);
    newName_path = fullfile(dirpath, newname);
    movefile(oldName_path, newName_path);  
end

  %to be manually corrected name
fprintf(fileid, '\r\n\r\n\t\t\t%s\r\n', 'unsucessfull attempts');
fprintf(fileid, '%s\r\n', 'erronous_names');
for t=1:size(manualcrt, 1)
    fprintf(fileid, '%24s\r\n', fnames{1}{manualcrt(t, 1), :});
end
fclose(fileid);

%file containing the name of the erronous file names
fileid = fopen('manualCorrection.txt', 'w');
fprintf(fileid, '%s', fnames{1}{manualcrt(:, 1), :});
fclose(fileid);

toc