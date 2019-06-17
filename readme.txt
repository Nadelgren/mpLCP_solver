The files contained here provide a rudimentary implementation of the Multiparametric Linear 
Complementarity Problem (mpLCP) solver proposed by Nathan Adelgren in the 5th chapter of his PhD 
dissertation titled, "Solution Techniques for Classes of Biobjective and Parametric Programs" 
(https://tigerprints.clemson.edu/cgi/viewcontent.cgi?article=2755&context=all_dissertations).
This code was primarily written by Nathan Adelgren in 2016 during work on his PhD at Clemson University.
Since that time, edits have been made based on helpful comments from colleagues.

This implementation was programmed using MATLAB and requires both the symbolic and optimization 
toolboxes. The program will not function if either of these toolboxes are unavailable. This program
solves mpLCP, i.e., the following system:

    w - M(x)z = q(x)
    w'z = 0
    w >= 0
    z >= 0
    
where x is a k-dimensional vector of parameters which lies in an "attainable" set X, w and z are 
h-dimensional vectors of decision variables, M(x) is an h-by-h matrix of affine functions of x, and q(x)
is an h-dimensional vector of affine functions of x. Also note that an apostrophe has been used above to
denote matrix transpose. For background information on mpLCP, please see the above mentioned dissertation 
and the references therein.

The main MATLAB file containing the implementation of the mpLCP solver is titled "solve_mpLCP.m" and 
therefore solving an instance of mpLCP is done using a call in MATLAB such as the following:

    solve_mpLCP(h,k,M,q,A,b)
    
Please note two things: (1) in order for this call to function correctly, the directory containing the 
file "solve_mpLCP.m" (and all other files included herein) must be either in MATLAB's current working 
directory or in its PATH, and (2) the function solve_mpLCP takes six parameters, which are described 
below:

    h -- an integer -- the dimension of mpLCP decision variable vectors.
    k -- an integer -- the number of parameters present in the instance of mpLCP.
    M -- a matrix   -- describes the nonzero contents of M(x) in the following format:
                       Each row of M must consist of four entries: 
                            (1) row index
                            (2) column index
                            (3) parameter index (0 indicates the constant term)
                            (4) coefficient
                       See below for an example.
    q -- a matrix   -- describes the nonzero contents of q(x) in the same format used above for M.
    A -- a matrix   -- it is assumed in this implementation that the set X can be represented as a system 
                       of linear inequalities in the form Av <= b. Hence, A describes the nonzero entries 
                       of matrix A in the following format:
                       Each row of A consists of three entries:
                            (1) row index
                            (2) column index
                            (3) coefficient
    b -- a vector   -- provides the elements of the vector b, as described above. Note that b should be 
                       given in column format and even zero elements must be included.
                       
An example:

    Consider the following instance of mpLCP:
            -                               -       -             -
            |   0       0       -2      -1  |       |   -x2 - 1   | 
            |   0       0       -5    x1 + 7|       | x1 - x2 - 1 |
        w - |   1       3       0       0   | z  =  | -18x2 - 34  |
            |   1   -x1 - 5     0       0   |       |  -9x2 - 17  |
            -                               -       -             -
        w'z = 0
        w >= 0
        z >= 0
        
        with -3 <= x1 <= 1 and -3 <= x2 <= 1.
        
    To solve this instance, one would use the following commands:
        
        h = 4;
        k = 2;
        M = [1,3,0,-2;
             1,4,0,-1;
             2,3,0,-5;
             2,4,0,7;
             2,4,1,1;
             3,1,0,1;
             3,2,0,3;
             4,1,0,1;
             4,2,0,-5;
             4,2,1,-1;];
        q = [1,0,-1;
             1,2,-1;
             2,0,-1;
             2,2,-1;
             2,1,1;
             3,0,-34;
             3,2,-18;
             4,0,-17;
             4,2,-9;];      
        A = [1,1,-1;
             2,2,-1;
             3,1,1;
             4,2,1;];
        b = [3;
             3;
             1;
             1;];
        r = solve_mpLCP(h,k,M,q,A,b);  
 
        
Note that upon execution, the file "solution.txt" is generated which contains the solution to the 
provided instance of mpLCP. The file contains the nonzero decision variable values (as functions of x) 
for each invariancy region (for the definition of an invariancy region, see the above referenced 
dissertation). Note that the invariancy region itself is given by the semi-algebraic set resulting from 
setting each given function greater than or equal to zero.

In the case in which k=2, the provided code also generates a plot of the set of invariancy regions on the 
region 0 <= x1 <= 1, 0 <= x2 <= 1. (This range can be modified in the file "plot_RHS.m", if desired.) 
An additional file titled "colors_used.txt" is also produced whenever this plot is generated. This file 
contains the randomly generated RGB color vectors associated with each invariancy region in the plot.


As stated, this implementation is very basic and as such, its functionality is limited and not guaranteed
in all cases. Questions and comments are welcome via email at nadelgren@edinboro.edu. A cleaner, more 
robust implementation is planned for future release and will be made available when complete.

____________________________________________________________________


This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
