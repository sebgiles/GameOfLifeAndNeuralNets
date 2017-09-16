function F = batchOfLife(X, n)
  A = num2cell(X,2);

  for k = 1 : length(A)
    V = A{k}; % k-th world row-vector
    ws = sqrt(length(V)); % world side length
    M = reshape(V, [ws,ws]); % k-th world matrix
    M = gameOfLife(M,n);
    A{k} = reshape(M, [1,ws*ws]);
  end

  F = cell2mat(A);
end
