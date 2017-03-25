function mat = getcorresp(fnames, db, endpoint)
    %compute the correspondance vector between two arrays

    %predefine the mat array
    row = size(fnames{:}, 1);
    mat = zeros(row, 3);
    
    %get the size of the db once for all
    numrows = size(db{:}, 1);
    
    %corresp. for each row in fname
    for t=1:row
        [dbIndex, score] = getmaxscore(fnames{1}{t}, db, numrows, endpoint);
       mat(t, :) = [t, dbIndex, score];
    end
end