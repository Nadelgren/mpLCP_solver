function Y=pivot(A,k,l)
%This function performs the pivot
%operation on the (k,l) entry of the matrix A.
global undo;
undo=A;

A_=A;
[m,n]=size(A_);

if (A_(k,l) == 0)

'You can not pivot on this entry; it is 0'
error(' ')

else
  A_(k,:)= (1/A(k,l))*A_(k,:);
  for r= 1:k-1
  A_(r,:)= A_(r,:) - A_(r,l)*A_(k,:);
  end

  for r= k+1:m
  A_(r,:)= A_(r,:) - A_(r,l)*A_(k,:);
  end
Y=A_;

end

