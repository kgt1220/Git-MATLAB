
function [order_Vx,order_Vy,order_Vz,order_R,order_A,xyz_position] = LR_order_xyz_news(r,N,a,q,K,w,h,x1ran,y1ran,z1ran,init_time)
    inixyz = [x1ran(:);y1ran(:);z1ran(:)];
    [position] = func_runkutt4_ex(inixyz,init_time,h,  r,q,K,w,a,N);
    xyz_position = position(:,end);
    x = position(1:N,:); y = position(N+1:2*N,:); z = position(2*N+1:3*N,:);  
    
theta2 = atan2(x,y);
theta = abs(mean(exp(1i*theta2)));
order_R = mean(theta(end-10000:end));

varix = var(x(:,end-10000:end)'); variy = var(y(:,end-10000:end)'); variz = var(z(:,end-10000:end)');
order_Vx = mean(exp(-varix)); order_Vy = mean(exp(-variy)); order_Vz = mean(exp(-variz));
order_A = mean((max(x(:,end-10000:end)')-min(x(:,end-10000:end)')));

end

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

function [sol] = lorenz(xyz,~, r,q,K,w,a,N) % a : top
   %s = zeros(N,N); 
   x = xyz(1:N); y = xyz(N+1:2*N); z = xyz(2*N+1:3*N); x_mean = mean(x);

   s = bsxfun(@minus,x(:)',x(:)); force = K.*(q*x_mean-x);

   dxdt=w.*(10*(y-x)+force);
   dydt=w.*(-x.*z+r*x-y);
   dzdt=w.*(x.*y-(8/3)*z);   
   sol = [dxdt;dydt;dzdt];
end