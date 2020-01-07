%% RC에서의 Wout을 구하기 위한 함수

function [Wout] = func_RC_training(X_train,Yt_train)
% train the output
%reg = 1e-8;  % regularization coefficient
%X_T = X_train;
%Wout = Yt_train*X_T * inv(X_train*X_T + reg*eye((N-inSize)*10));

Wout = Yt_train'*pinv(X_train);
end
