function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices.
%
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight
% matrices for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size ...
                 + 1))):end), num_labels, (hidden_layer_size + 1));

% Setup variables
% X is the training set inputs
% Theta is the Cell Array of parameter Matrices
Theta = {Theta1, Theta2};
% s_l is the number of nodes in the lth layer
% ROWS ARE OUTPUTS      s_(l+1)
% same as the number of nodes in the next layer
% COLUMNS ARE INPUTS    s_l + 1
% same as the number of nodes in its layer plus the bias node
% L is the number of layers
L = size(Theta,2);
% X is the training set inputs
% M is the number of training samples
M = size(X, 1);
% K is the number of nodes in the output layer, also the number of classes
K = num_labels;
% y is the training set outputs
% y is given as an M dimensional vector of values from 1 to 10
% It is convenient to turn it into an M*K matrix of 0 and 1
y = ones(M, 1)*[1:K]==y;
% Coursera's way..
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
% Theta_grad is the cell array of gradients
Theta_grad = {Theta1_grad, Theta2_grad};

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

% a is a cell array of matrices, one per layer, rows are samples (M), columns
% are nodes. We need to keep them for computing gradients later on.
a{1} = [ones(M,1), X];
z = {};
% This is forward propagation
for l=1:L;
  z{l+1} = a{l}*(Theta{l})';
  a{l+1} = [ones(M,1),sigmoid(z{l+1})];
end

% h are the hypothesis for the training set
h = a{L+1}(:,2:end);

% J is the cost function
J = 1/M*sum(sum( -y.*log(h) - (1-y).*log(1-h) ));

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives
%         of the cost function with respect to Theta1 and Theta2 in Theta1_grad
%         and Theta2_grad, respectively. After implementing Part 2, you can
%         check that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% Remember we are not regularizing the weights for the bias terms!

reg=0;
% iterating over layers
for l=1:L;
  reg=reg+sum(sum(Theta{l}(:,2:end).^2));
end

J=J+lambda/(2*M)*reg;

% -------------------------------------------------------------
% this is the gold: BACKPROPAGATION

% d (lowercase delta) is a cell array of matrices, each matrix is a layer, each
% row is an example, each column is an output. we are talking about errors
d{L+1} = h - y;
for l=L:-1:2;
  d{l} = d{l+1}*Theta{l}(:,2:end).*sigmoidGradient(z{l});
end

for l=1:L;
  Theta{l}(:,1)=0;
  Theta_grad{l}=(d{l+1}'*a{l}+lambda*Theta{l})/M;
end
% =========================================================================

% Unroll gradients
grad = [];
for l=1:L;
  grad = [grad; Theta_grad{l}(:)];
end

end
