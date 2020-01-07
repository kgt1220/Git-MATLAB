% A minimalistic Echo State Networks demo with Mackey-Glass (delay 17) data 
% in "plain" Matlab.
% by Mantas Lukosevicius 2012
% http://minds.jacobs-university.de/mantas

% reservoir computing에서 가장 많이 사용되는 model. machine learning에서 주로 사용하는 neural network을 기반으로 하고 있고
% 제가 주로 사용하는 oscillator ( ode로 표현되는 현상 )과는 차이가 있음
% 영어로만 적혀있는 설명은 모두 기존에 적혀있었던 것으로 무시해도 됨.

%% load the data / Part1 -> input을 설정함.
% 엄청 많은 반복작업이나 저장을 하는 코드가 아닌 지금 이 코드같은 경우에서는 init,train,test구간과 output으로
% 사용할 데이타를 미리 만들어놓는 부분

trainLen = 2000; % train시킬 길이, 보통 input에 따라서 충분히 훈련시켜야 하는 길이가 달라짐.
testLen = 2000;

initLen = 100; % reservoir의 안정성과 충분한 정보를 자르기 위해 사전에 자르는 구간.
% 예를 들어 이 구간이 없다면 첫번째 reservoir vector의 input dynamic의 과거 정보를 모르지만 이 구간이
% 있다면 실제로 사용할 첫번째 reservoir vector에는 앞의 100개 input에 대한 정보도 어느정도 갖고
% 있음.(initLen = 100 인 경우)

data = load('MackeyGlass_t17.txt'); % data를 부름. mackeyglass라는 1차원의 time delay dynamic의 attractor 정보를 갖고옴.
% 이 경우는 다른 연구에서 사용한 정보를 갖고와서 txt파일로 저장되어 있어서 이렇게 갖고오지만 다른 data의 경우는 그냥 .mat로 저장해두고 가져옴.


%% generate the ESN reservoir / Part2.1 -> train과 test에 사용할 reservoir matrix (input에 대한 정보)를 만들기 위한 설정.
inSize = 1; outSize = 1; % input이 한 개의 time series이고 output은 그 prediction이므로 한개씩만 있음.
% 만약 input이 2개의 정보 
% ex) input1:시간에 따른 전기 소비량 / input2:시간에 따른 가스 소비량 / output: 시간에 따른 발전소 부하인 경우 insize=2, outsize=1
% 만약 하나의 정보로 2개를 알고 싶으면 insize = 1, outsize = 2. 이경우는 insize=1,outsize=1짜리 2개도 같은 결과를 얻을 수 있음. 

resSize = 1000; % 서로 상호작용하는 reservoir system의 size로 oscillator의 경우 node라고 말함. 다른 코드들에서 N이라고 표현.
a = 0.3; % leaking rate로 oscillator기반 reservoir에서 input이 들어온 뒤에 다시 synchronize하게 만드는 것과 같은 역할

Win = (rand(resSize,1+inSize)-0.5) .* 1; % input을 neural node에 넣을 때 곱해주는 matrix로 고정되어 있음.
% 1+insize인 이유는 neural network을 기반으로 할 경우 bias의 역할을 해줄(아마?) 1값을 계속
% computing에 포함 시키기 위해서로 알고있음. 아래 reservoir만드는 알고리즘을 보면 좀 더 와닿음.

W = rand(resSize,resSize)-0.5; % reservoir안의 neural node들이 서로 반응할 정도를 정해주는 matrix로 고정되어 있음.
% Option 1 - direct scaling (quick&dirty, reservoir-specific):
% W = W .* 0.13;
% Option 2 - normalizing and setting spectral radius (correct, slower):
disp 'Computing spectral radius...';
opt.disp = 0;
rhoW = abs(eigs(W,1,'LM',opt));
disp 'done.'
W = W .* ( 1.25 /rhoW);
% option 둘중에 어느것을 선택해도 상관없으며 option2가 수학적으로 좀 더 깔끔함. 1은 약간 때려맞추는 느낌
% 여기서 하는 작업의 핵심은 neural node들간에 상호작용하는 network을 표현하는 matrix의 spectral
% redius를 작게(정확하지는 않음. spectral radius를 기준으로 어떤 조건을 맞추려고함. 아마 blow up 안하게 하려고) 만드려고 함. 

% allocated memory for the design (collected states) matrix
X = zeros(1+inSize+resSize,trainLen-initLen); % reservoir로 사용할 matrix 크기 미리 만듬
% set the corresponding target matrix directly
Yt = data(initLen+2:trainLen+1)'; % output으로 사용할 데이터 만듬 ( real-time prediction을 위한 data로 1초 후를 예측하게 설정 )

%% Part2.2 reservoir를 실제로 만드는 알고리즘.
% 위의 parameter들을 대입해서 reservoir를 생성하는 파트
% run the reservoir with the data and collect X

x = zeros(resSize,1); %매 input이 들어올 때마다의 neural node들의 정보를 저장할 vector

for t = 1:trainLen
	u = data(t); % input하나 갖고옴.
	x = (1-a)*x + a*tanh( Win*[1;u] + W*x ); 
    % input에 따라 node들이 반응하는 식. neural network을 기반으로 하는 reservoir computing인
    % echo state machine의 경우는 모두 동일한 식으로 알고 있음. 식 한두개 첨가하거나 tanh를 다른
    % activation function(ex. sigmoid function)으로 바꾸는 정도가 대부분.
    % oscillator를 이용한 rc와 가장 큰 차이는 input을 넣고 기다리면서 정보를 추출하는게 아니라 알고리즘 한번만다 계산한 값들이 정보가 됨.
	if t > initLen % 처음 저장하지 않을 기간을 무시하기 위해
		X(:,t-initLen) = [1;u;x]; %reservoir로 저장
	end
end

%% train the output / Part3 : reservoir computing에서 유일한 train파트로 
% reservoir matrix와 target output을 연결해주는 Wout(readout이라고도 함.)을 만드는 부분.

reg = 1e-8;  % regularization coefficient로 인공적으로 설정되는 값. 이유는 그냥 이것저것 해보다가 잘되어서 이 값으로 설정하는 것으로 암.
X_T = X';
% option1
Wout = Yt*X_T * inv(X*X_T + reg*eye(1+inSize+resSize));
% option2
% Wout = Yt*pinv(X);
% 두 과정 모두 원하는 target output이 나오는 최적의 Wout을 구하는 과정이지만 결과도 조금은 다르고 한개는 에러가 뜨지만 다른 것은 안그런 경우도 있음.
% reservoir computing을 하는 경우 ( 특히 저는 ) reservoir system으로 무엇을 쓰느냐에 주로 관심이
% 있어서 이 부분은 자세히 알지 못하고 그냥 matlab built-in function인 pinv를 사용함.
%% Part4 : error를 구하는 부분
% --------------------------------- real-time prediction인 경우에만 존재하는 부분으로

% run the trained ESN in a generative mode. no need to initialize here, 
% because x is initialized with training data and we continue from there.
Y = zeros(outSize,testLen);
u = data(trainLen+1);
for t = 1:testLen 
	x = (1-a)*x + a*tanh( Win*[1;u] + W*x );
	y = Wout*[1;u;x];
	Y(:,t) = y;
	% generative mode:
	u = y;
	% this would be a predictive mode:
	%u = data(trainLen+t+1);
end
% ----------------------------------- 원래는 test로 사용할 reservoir도 위에서 미리 만들어
% 놓고 아래서 잘라서 사용함. ( real-time prediction은 예측한걸 넣고 그걸로 test에 사용할 resevoir만드는 작업을 반복)

errorLen = 500; % error를 구하는데 사용할 길이를 설정하는 것으로 사실은 그냥 testLen을 이용해도 되는데 
% 이 코드는 test하기 위해 만든 부분중에서도 일부분만 테스트 하고 싶었던거 같음.

mse = sum((data(trainLen+2:trainLen+errorLen+1)'-Y(1,1:errorLen)).^2)./errorLen; % error 구하는 방식으로 아무거나 써도됨.
original_MSE = sum((data(trainLen+2:trainLen+errorLen+1)').^2)./errorLen;
disp( ['MSE = ', num2str( mse )] );

%% Part5 : plotting -> 여기는 그냥 자기 보고싶은걸 plot 
% plot some of it
figure(11);
plot(data(1:1000));
title('A sample of data');

% plot some signals
figure(1);
plot( data(trainLen+2:trainLen+testLen+1), 'color', [0,0.75,0] );
hold on;
plot( Y', 'b' );
hold off;
axis tight;
title('Target and generated signals y(n) starting at n=0');
legend('Target signal', 'Free-running predicted signal');

figure(2);
plot( X(1:5,1:200)' );
title('Some reservoir activations x(n)');

figure(3);
bar( Wout' )
title('Output weights W^{out}');
