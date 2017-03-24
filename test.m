%%build test images
for t=1:100
   im = randi(255, 10);
   
end




%% build the file names txt file
%create the 'fnames.txt' file
% list = dir('files/*.rtf');
% fn = {list.name};
% fn = fn';
% fn = cell2table(fn);
% writetable(fn,'fnames.txt', 'WriteVariableNames', false);


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
fnameFolderIndex = log(:, 1);
detectedName = char(fnames(fnameFolderIndex, :));
fnameDBIndex = log(:, 2);
correctedName = char(db(fnameDBIndex, :));
score = log(:, 3);
t = table(fnameFolderIndex, detectedName, fnameDBIndex, correctedName, score);


%% output the result in a text file
writetable(t,'logFile','FileType','spreadsheet');
writetable(t,'logFile.txt','Delimiter','|');


%% update the file names in the folder
updatedNames = fnames;
updatedNames(fnameFolderIndex, :) = db(fnameDBIndex, :);
st = table(char(updatedNames));
writetable(st,'updatedNames.txt', 'WriteVariableNames', false);


%% change the file names inside the folder
