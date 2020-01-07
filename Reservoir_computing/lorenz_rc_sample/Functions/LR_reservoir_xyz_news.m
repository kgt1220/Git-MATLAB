%% resvoir만들기 위한 function들 모아둠. 
%% ---------------------------------------------------------------------
% input에 대한 lorenz oscillator의 반응을 정보화(일종의 가공)시키는 부분
% 아래 두 function을 이용해서 구한 lorenz oscillator의 position정보를 frequency형태로 가공해 
% 한 input마다 한 벡터를 주도록 만듬.
% echo와 다르게 이렇게 input마다 넣고 '1.기다리면서 반응을 봄. 2. 반응을 가공'하는 과정이 있음
function [reservoir_x, reservoir_y, reservoir_z] = LR_reservoir_xyz_news(r,N,a,q,K,limit,w,in,h,xyz_given)
%    inixyz = [x1ran(:);y1ran(:);z1ran(:)]; tfin = 1; reservoir = zeros(10*(N-1),limit); init_time = 500;
%    [position] = func_runkutt4_ex(inixyz,init_time,h,  r,ep,w,a,N); Hinvd10 = round(1/(h*10));
    xyz_position = xyz_given; tfin = 1; reservoir_x = zeros(10*(N-1),limit); reservoir_y = zeros(10*(N),limit); reservoir_z = zeros(10*(N),limit); Hinvd10 = round(1/(h*10));
    for variable_i = 1:limit
        xyz_position(1) = xyz_position(1)+in(variable_i);
        [position] = func_runkutt4_ex(xyz_position,tfin,h,  r,q,K,w,a,N);
        reservoir_position_x = position(2:N,:); reservoir_position_y = position(N+1:2*N,:); reservoir_position_z = position(2*N+1:3*N,:);
        
        pre_reservoir_x = (reservoir_position_x(:,Hinvd10+1:Hinvd10:end)-reservoir_position_x(:,Hinvd10:Hinvd10:end-1))/h; %unit_reservoir = pre_reservoir(:); 
        reservoir_x(:,variable_i) = pre_reservoir_x(:); 
        
        pre_reservoir_y = (reservoir_position_y(:,Hinvd10+1:Hinvd10:end)-reservoir_position_y(:,Hinvd10:Hinvd10:end-1))/h; %unit_reservoir = pre_reservoir(:); 
        reservoir_y(:,variable_i) = pre_reservoir_y(:); 
        
        pre_reservoir_z = (reservoir_position_z(:,Hinvd10+1:Hinvd10:end)-reservoir_position_z(:,Hinvd10:Hinvd10:end-1))/h; %unit_reservoir = pre_reservoir(:); 
        reservoir_z(:,variable_i) = pre_reservoir_z(:); 
        
        xyz_position = position(:,end);
    end
end

%% ----------------------------------------------------------------
% rk4 방식으로 맨 아래 system을 풀어주는 부분 다른 부분 안건드리고 lorenz(parameter)부분 4개만 다른 system으로 수정하면 해당 system을
% 풀어줌
function [soln] = func_runkutt4_ex(inixyz,tfin,h,  r,q,K,w,a,N)
% Runge-Kutta 4th order integration

%% preset
	t = 0:h:tfin; % setting timesteps
	soln = zeros(length(inixyz),round((tfin)/h)+1); % solution matrix (return value of this function)
	soln(:,1) = inixyz(:); % triggering initial value
	k = zeros(length(inixyz),4);
   
%% performing Runge-Kutta4 integration

	i = 1;
    while (i < length(t))
		k(:,1) = h * lorenz(soln(:,i),t(i), r,q,K,w,a,N);
		k(:,2) = h * lorenz(soln(:,i)+k(:,1)/2,t(i)+h/2, r,q,K,w,a,N);
		k(:,3) = h * lorenz(soln(:,i)+k(:,2)/2,t(i)+h/2, r,q,K,w,a,N);
		k(:,4) = h * lorenz(soln(:,i)+k(:,3),t(i)+h, r,q,K,w,a,N);
		soln(:,i+1) = soln(:,i)+(k(:,1)+2.0*k(:,2)+2.0*k(:,3)+k(:,4))/6.0;
%        k = h * kuramoto(soln(:,i),t(i),  N,K,w,a);
%        soln(:,i+1) = soln(:,i)+k(:,1);
		i = i+1;
    end

end

%% -------------------------------------------------------------
% 풀고 싶은 system을 적어놓는 곳. 예를들어 여기에 kuramoto model을 적어놓으면 kuramoto rc가 됨.
% 지금 적은 system은 lorenz system
function [sol] = lorenz(xyz,~, r,q,K,w,a,N) % a : top
   %s = zeros(N,N); 
   x = xyz(1:N); y = xyz(N+1:2*N); z = xyz(2*N+1:3*N); x_mean = mean(x);

   s = bsxfun(@minus,x(:)',x(:)); s = s.*a; force = K.*(q*x_mean-x);

   dxdt=w.*(10*(y-x)+force);
   dydt=w.*(-x.*z+r*x-y);
   dzdt=w.*(x.*y-(8/3)*z);   
   sol = [dxdt;dydt;dzdt];
end