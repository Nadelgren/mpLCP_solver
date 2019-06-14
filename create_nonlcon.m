function [c,ceq] = create_nonlcon(a,b,x)
size_b = size(b,1);
X = num2cell(x);
c = a(X{:});
if(size_b> 0) ceq = b(X{:});
else ceq = [];
end