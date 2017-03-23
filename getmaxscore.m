function score = getmaxscore(fname, db, numrow)
    %build a N X 1 array with fname
    fname = repmat(fname, [numrow, 1]);
    
    %compare fname with the database db and add the rows
    score = fname == db;
    score = sum(score, 2);
end