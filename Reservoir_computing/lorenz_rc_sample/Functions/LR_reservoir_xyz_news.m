%% resvoir����� ���� function�� ��Ƶ�. 
%% ---------------------------------------------------------------------
% input�� ���� lorenz oscillator�� ������ ����ȭ(������ ����)��Ű�� �κ�
% �Ʒ� �� function�� �̿��ؼ� ���� lorenz oscillator�� position������ frequency���·� ������ 
% �� input���� �� ���͸� �ֵ��� ����.
% echo�� �ٸ��� �̷��� input���� �ְ� '1.��ٸ��鼭 ������ ��. 2. ������ ����'�ϴ� ������ ����
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
% rk4 ������� �� �Ʒ� system�� Ǯ���ִ� �κ� �ٸ� �κ� �Ȱǵ帮�� lorenz(parameter)�κ� 4���� �ٸ� system���� �����ϸ� �ش� system��
% Ǯ����
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
% Ǯ�� ���� system�� ������� ��. ������� ���⿡ kuramoto model�� ��������� kuramoto rc�� ��.
% ���� ���� system�� lorenz system
function [sol] = lorenz(xyz,~, r,q,K,w,a,N) % a : top
   %s = zeros(N,N); 
   x = xyz(1:N); y = xyz(N+1:2*N); z = xyz(2*N+1:3*N); x_mean = mean(x);

   s = bsxfun(@minus,x(:)',x(:)); s = s.*a; force = K.*(q*x_mean-x);

   dxdt=w.*(10*(y-x)+force);
   dydt=w.*(-x.*z+r*x-y);
   dzdt=w.*(x.*y-(8/3)*z);   
   sol = [dxdt;dydt;dzdt];
end