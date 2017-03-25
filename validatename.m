function outputname = validatename( inputname, endpoint)
%a valid 17 char names from string names
    inputname = inputname(1, 1:end-endpoint);
    
    parts = strsplit(inputname, '_');
    len = length(parts);
%     part1 = ''; part2 = ''; part3 = ''; part4 = '';
    dummy = 'XXXX';
    
    switch(len)
        case 1
            part1 = parts{1}; part2 = dummy;
            part3 = dummy;   part4 = dummy;
        case 2
            part1 = parts{1}; part2 = parts{2};
            part3 = dummy;   part4 = dummy;
        case 3
            part1 = parts{1}; part2 = parts{2};
            part3 = parts{3};   part4 = dummy;
        case 4
            part1 = parts{1}; part2 = parts{2};
            part3 = parts{3};   part4 = parts{4};
        otherwise
            part1 = 'XXXXX'; part2 = dummy;
            part3 = dummy;   part4 = dummy;
    end
    
    if length(part1) ~= 5
        part1 = 'XXXXX';
    end;
    if length(part2) ~= 4
        part2 = dummy; 
    end;
    if length(part3) ~= 4
        part3 = dummy; 
    end;
    if length(part4) ~= 4
        part4 = dummy; 
    end;
    
    outputname = strcat(part1, part2, part3, part4);
end

