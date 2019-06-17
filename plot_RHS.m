function colors = plot_RHS(RHS,c,h,x,colors,bounds)
[X,Y]=meshgrid(bounds(1):(bounds(2)-bounds(1))/225:bounds(2),bounds(3):(bounds(4)-bounds(3))/225:bounds(4));
z = zeros(size(X));
ineq = [];
for i = 1:size(c,2)
     f = matlabFunction(c(i),'Vars',x);
     if(i == 1) 
         if(size(x,2) == 4) 
             ineq = f(X,Y,z,z) <= 0;
         else
             ineq = f(X,Y,z) <= 0;
         end
     else
         if(size(x,2) == 4) 
            ineq = ineq & f(X,Y,z,z) <= 0;
         else
            ineq = ineq & f(X,Y,z) <= 0;
         end
     end
end

if(isempty(colors)) 
    colors = ones(size(X(:),1),3);
    fileID = fopen('colors_used.txt','w');
else
    fileID = fopen('colors_used.txt','a');
end


for j = 1:size(RHS,1)
    ineq_new = ineq;
    for i = 1:h
         f = matlabFunction(RHS(j,i),'Vars',x);
         if(size(x,2) == 4) 
            ineq_new = ineq_new & f(X,Y,z,z) <= 0;
         else
            ineq_new = ineq_new & f(X,Y,z) <= 0;
         end
    end

    a = rand(1,3);
    in = ineq_new(:);
    for i=1:size(X(:),1)
        colors(i,:) = colors(i,:) - a*in(i);
    end
    fprintf(fileID,'[%f, %f, %f]\n\n',1-a(1),1-a(2),1-a(3));
end

fclose(fileID);
scatter(X(:),Y(:),4,colors,'filled')
