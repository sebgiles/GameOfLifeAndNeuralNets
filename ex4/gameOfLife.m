% apply n steps of life to square matrix A
function F = gameOfLife(A,n)

  ws = length(A); % world size
  F = zeros(ws); % future world

  for s = 1 : n % iterate through time

    for i = 1 : ws % loop through rows
      for j = 1 : ws % loop through columns
        nc = 0; % current cell neighbour count

        % count neighbours on row above
        if i ~= 1

          % top left
          if j ~= 1
            nc = nc + A(i-1, j-1);
          end

          % top center
          nc = nc + A(i-1, j);

          % top right
          if j ~= ws
            nc = nc + A(i-1, j+1);
          end

        end

        % count left neighbour
        if j ~= 1
          nc = nc + A(i, j-1);
        end

        % count right neighbour
        if j ~= ws
          nc = nc + A(i, j+1);
        end

        % count neighbours on row below
        if i ~= ws

          % bottom left
          if j ~= 1
            nc = nc + A(i+1, j-1);
          end

          % bottom center
          nc = nc + A(i+1, j);

          % bottom right
          if j ~= ws
            nc = nc + A(i+1, j+1);
          end

        end

        % evaluate future occupation of cell
        if nc < 2
          F(i,j) = 0;
        end
        if nc == 2
          F(i,j) = A(i,j);
        end
        if nc == 3
          F(i,j) = 1;
        end
        if nc > 3
          F(i,j) = 0;
        end

      end %column loop
    end %row loop
    A = F; % moves new world into old world for iterating
  end %time loop
  %spy(A);
  %pause(0.1)
end %function
