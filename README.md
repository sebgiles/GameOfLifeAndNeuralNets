# TODO
 - game of life function, takes a binary matrix and n, return binary matrix
 after n steps of life:

 seems to be working !

 - benchmark with black and white (binary) vs grey scale on Stanford example:

 same training set accuracy (~95%), perfect !

 - batch game of life function to process whole X matrix with n
 steps of GoL

 . turn X matrix into cell array of column vector

 . iterate over each vector in the cell array

 . . reshape column vector into world matrix

 . . run GoL n times on the matrix

 . . reshape matrix into vector

 . num2cell back to original format

 - run the NN training three times for each iteration of GoL on the dataset
