function [I, score] = getmaxscore(fname, db, numrow)
    %get the max score of a filename from a given db

    %build a N X 1 array with fname
    fname = repmat(fname, [numrow, 1]);
    
    %compare fname with the database db and add the rows
    score = fname == db;
    [score, I] = max(sum(score, 2));
end