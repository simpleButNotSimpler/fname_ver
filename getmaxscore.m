function [I, topscore] = getmaxscore(fname, db, numrow, endpoint)
    %get the max score of a filename from a given db
    
    fname = validatename(fname, endpoint);
    topscore = 0;
    I = 1;
    
    %compare fname with the database db and add the rows
    for t=1:numrow
        dbname = validatename(db{1}{t}, endpoint);
        actualscore = sum(fname == dbname, 2);
        
        if actualscore > topscore
            topscore = actualscore; 
            I = t;
        end
        
        if topscore == 17
            break;
        end
    end
end