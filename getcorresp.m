function mat = getcorresp(fnames, db)
    %compute the correspondance vector between two arrays

    %predefine the mat array
    [row, ~] = size(fnames);
    mat = zeros(row, 3);
    
    %get the size of the db once for all
    [numrows, ~] = size(db);
    
    %corresp. for each row in fname
    for t=1:row
        [dbIndex, score] = getmaxscore(fnames(t, :), db, numrows);
       mat(t, :) = [t, dbIndex, score]; 
    end
end