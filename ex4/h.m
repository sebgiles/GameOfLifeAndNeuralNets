% satisfied are you? ahah
function X = h(Thetas, X)

	for i=1:size(Thetas, 2);
		X = [ones(size(X,1),1) ,X];

		X=sigmoid(X*(Thetas{i})');
	end

end
