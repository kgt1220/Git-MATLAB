% A minimalistic Echo State Networks demo with Mackey-Glass (delay 17) data 
% in "plain" Matlab.
% by Mantas Lukosevicius 2012
% http://minds.jacobs-university.de/mantas

% reservoir computing���� ���� ���� ���Ǵ� model. machine learning���� �ַ� ����ϴ� neural network�� ������� �ϰ� �ְ�
% ���� �ַ� ����ϴ� oscillator ( ode�� ǥ���Ǵ� ���� )���� ���̰� ����
% ����θ� �����ִ� ������ ��� ������ �����־��� ������ �����ص� ��.

%% load the data / Part1 -> input�� ������.
% ��û ���� �ݺ��۾��̳� ������ �ϴ� �ڵ尡 �ƴ� ���� �� �ڵ尰�� ��쿡���� init,train,test������ output����
% ����� ����Ÿ�� �̸� �������� �κ�

trainLen = 2000; % train��ų ����, ���� input�� ���� ����� �Ʒý��Ѿ� �ϴ� ���̰� �޶���.
testLen = 2000;

initLen = 100; % reservoir�� �������� ����� ������ �ڸ��� ���� ������ �ڸ��� ����.
% ���� ��� �� ������ ���ٸ� ù��° reservoir vector�� input dynamic�� ���� ������ ������ �� ������
% �ִٸ� ������ ����� ù��° reservoir vector���� ���� 100�� input�� ���� ������ ������� ����
% ����.(initLen = 100 �� ���)

data = load('MackeyGlass_t17.txt'); % data�� �θ�. mackeyglass��� 1������ time delay dynamic�� attractor ������ �����.
% �� ���� �ٸ� �������� ����� ������ ����ͼ� txt���Ϸ� ����Ǿ� �־ �̷��� ��������� �ٸ� data�� ���� �׳� .mat�� �����صΰ� ������.


%% generate the ESN reservoir / Part2.1 -> train�� test�� ����� reservoir matrix (input�� ���� ����)�� ����� ���� ����.
inSize = 1; outSize = 1; % input�� �� ���� time series�̰� output�� �� prediction�̹Ƿ� �Ѱ����� ����.
% ���� input�� 2���� ���� 
% ex) input1:�ð��� ���� ���� �Һ� / input2:�ð��� ���� ���� �Һ� / output: �ð��� ���� ������ ������ ��� insize=2, outsize=1
% ���� �ϳ��� ������ 2���� �˰� ������ insize = 1, outsize = 2. �̰��� insize=1,outsize=1¥�� 2���� ���� ����� ���� �� ����. 

resSize = 1000; % ���� ��ȣ�ۿ��ϴ� reservoir system�� size�� oscillator�� ��� node��� ����. �ٸ� �ڵ�鿡�� N�̶�� ǥ��.
a = 0.3; % leaking rate�� oscillator��� reservoir���� input�� ���� �ڿ� �ٽ� synchronize�ϰ� ����� �Ͱ� ���� ����

Win = (rand(resSize,1+inSize)-0.5) .* 1; % input�� neural node�� ���� �� �����ִ� matrix�� �����Ǿ� ����.
% 1+insize�� ������ neural network�� ������� �� ��� bias�� ������ ����(�Ƹ�?) 1���� ���
% computing�� ���� ��Ű�� ���ؼ��� �˰�����. �Ʒ� reservoir����� �˰����� ���� �� �� �ʹ���.

W = rand(resSize,resSize)-0.5; % reservoir���� neural node���� ���� ������ ������ �����ִ� matrix�� �����Ǿ� ����.
% Option 1 - direct scaling (quick&dirty, reservoir-specific):
% W = W .* 0.13;
% Option 2 - normalizing and setting spectral radius (correct, slower):
disp 'Computing spectral radius...';
opt.disp = 0;
rhoW = abs(eigs(W,1,'LM',opt));
disp 'done.'
W = W .* ( 1.25 /rhoW);
% option ���߿� ������� �����ص� ��������� option2�� ���������� �� �� �����. 1�� �ణ �������ߴ� ����
% ���⼭ �ϴ� �۾��� �ٽ��� neural node�鰣�� ��ȣ�ۿ��ϴ� network�� ǥ���ϴ� matrix�� spectral
% redius�� �۰�(��Ȯ������ ����. spectral radius�� �������� � ������ ���߷�����. �Ƹ� blow up ���ϰ� �Ϸ���) ������� ��. 

% allocated memory for the design (collected states) matrix
X = zeros(1+inSize+resSize,trainLen-initLen); % reservoir�� ����� matrix ũ�� �̸� ����
% set the corresponding target matrix directly
Yt = data(initLen+2:trainLen+1)'; % output���� ����� ������ ���� ( real-time prediction�� ���� data�� 1�� �ĸ� �����ϰ� ���� )

%% Part2.2 reservoir�� ������ ����� �˰���.
% ���� parameter���� �����ؼ� reservoir�� �����ϴ� ��Ʈ
% run the reservoir with the data and collect X

x = zeros(resSize,1); %�� input�� ���� �������� neural node���� ������ ������ vector

for t = 1:trainLen
	u = data(t); % input�ϳ� �����.
	x = (1-a)*x + a*tanh( Win*[1;u] + W*x ); 
    % input�� ���� node���� �����ϴ� ��. neural network�� ������� �ϴ� reservoir computing��
    % echo state machine�� ���� ��� ������ ������ �˰� ����. �� �ѵΰ� ÷���ϰų� tanh�� �ٸ�
    % activation function(ex. sigmoid function)���� �ٲٴ� ������ ��κ�.
    % oscillator�� �̿��� rc�� ���� ū ���̴� input�� �ְ� ��ٸ��鼭 ������ �����ϴ°� �ƴ϶� �˰��� �ѹ����� ����� ������ ������ ��.
	if t > initLen % ó�� �������� ���� �Ⱓ�� �����ϱ� ����
		X(:,t-initLen) = [1;u;x]; %reservoir�� ����
	end
end

%% train the output / Part3 : reservoir computing���� ������ train��Ʈ�� 
% reservoir matrix�� target output�� �������ִ� Wout(readout�̶�� ��.)�� ����� �κ�.

reg = 1e-8;  % regularization coefficient�� �ΰ������� �����Ǵ� ��. ������ �׳� �̰����� �غ��ٰ� �ߵǾ �� ������ �����ϴ� ������ ��.
X_T = X';
% option1
Wout = Yt*X_T * inv(X*X_T + reg*eye(1+inSize+resSize));
% option2
% Wout = Yt*pinv(X);
% �� ���� ��� ���ϴ� target output�� ������ ������ Wout�� ���ϴ� ���������� ����� ������ �ٸ��� �Ѱ��� ������ ������ �ٸ� ���� �ȱ׷� ��쵵 ����.
% reservoir computing�� �ϴ� ��� ( Ư�� ���� ) reservoir system���� ������ �����Ŀ� �ַ� ������
% �־ �� �κ��� �ڼ��� ���� ���ϰ� �׳� matlab built-in function�� pinv�� �����.
%% Part4 : error�� ���ϴ� �κ�
% --------------------------------- real-time prediction�� ��쿡�� �����ϴ� �κ�����

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
% ----------------------------------- ������ test�� ����� reservoir�� ������ �̸� �����
% ���� �Ʒ��� �߶� �����. ( real-time prediction�� �����Ѱ� �ְ� �װɷ� test�� ����� resevoir����� �۾��� �ݺ�)

errorLen = 500; % error�� ���ϴµ� ����� ���̸� �����ϴ� ������ ����� �׳� testLen�� �̿��ص� �Ǵµ� 
% �� �ڵ�� test�ϱ� ���� ���� �κ��߿����� �Ϻκи� �׽�Ʈ �ϰ� �;����� ����.

mse = sum((data(trainLen+2:trainLen+errorLen+1)'-Y(1,1:errorLen)).^2)./errorLen; % error ���ϴ� ������� �ƹ��ų� �ᵵ��.
original_MSE = sum((data(trainLen+2:trainLen+errorLen+1)').^2)./errorLen;
disp( ['MSE = ', num2str( mse )] );

%% Part5 : plotting -> ����� �׳� �ڱ� ��������� plot 
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
