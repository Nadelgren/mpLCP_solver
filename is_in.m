function out = is_in(in,list)
% Returns a 1 if the string in is in list
out=0;
for i = 1:size(list,1)
    if(isequal(in,list(i,:)))
        out = 1;
        return
    end
end