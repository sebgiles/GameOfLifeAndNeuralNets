
%==========================================
%   apply game of life rules to  
%==========================================
function s=GOL (A,B,i,j)
% game of life rule
sm=0;
% count number of alive neighbors
sm=sm + B(i-1,j-1) +B(i-1,j)+B(i-1,j+1);
sm=sm + B(i,  j-1)          +B(i  ,j+1);
sm=sm + B(i+1,j-1) +B(i+1,j)+B(i+1,j+1);

% compute the new state of the current cell
s=B(i,j);
if B(i,j)==1
    if (sm>1)&&(sm<4)
        s=1;
    else
        s=0 ;   
    end
else
    if sm==3
       s=1;
    end
end