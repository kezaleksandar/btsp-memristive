% general constants
alpha = 7.5;
sigma = 0.9/(3*sqrt(2));
v = 0.5;

N = 50;
x0 = linspace(0,2,N);

% LTP constants
eta_p = 0.2;
tau_p = 0.2;
Tmax_p = 2.2;

% LTD constants
eta_d = 200;
tau_d = 1.5;
Tmax_d = 2;

% global instructive signal constants
gamma = 1.0;
tau_I = 3.5;
tP = 0.6;   %plateau induction time

tspan = [0 4];

%initial conditions
y0 = zeros(3*N,1);
y0(2*N+1:3*N) = 0.1;   % initial weight values (internalized resources)

[t,y] = ode45(@(t,y) trace_model(t,y,N,x0,alpha,sigma,v,...
                                 eta_p,tau_p,Tmax_p,...
                                 eta_d,tau_d,Tmax_d,...
                                 gamma,tau_I,tP),...
                                 tspan,y0);

Tp_vals = y(:,1:N);
Td_vals = y(:,N+1:2*N);
W_vals  = y(:,2*N+1:3*N);

%extracting values for specific synapses
i1 = 10;
i2 = 40;

Tp_i1 = Tp_vals(:,i1);
Td_i1 = Td_vals(:,i1);
W_i1  = W_vals(:,i1);

Tp_i2 = Tp_vals(:,i2);
Td_i2 = Td_vals(:,i2);
W_i2  = W_vals(:,i2);

% global instructive signal P(t) -> ovo je isto za sve sinapse, ne zavisi
% od i
P_t = zeros(size(t));
for k = 1:length(t)
    if t(k) < tP  %dakle gleda se samo u odnosu na tP vreme indukovanja platoa
        P_t(k) = 0;
    else
        P_t(k) = gamma * exp(-(t(k)-tP)/tau_I);
    end
end

%plotting two synapses, i1 = 10 and i2 = 40
figure
plot(t,Tp_i1,'b','LineWidth',2); hold on
plot(t,Td_i1,'r','LineWidth',2)
plot(t,P_t,'g','LineWidth',2)
plot(t,W_i1,'k','LineWidth',2)

xlabel('Time [s]')
ylabel('Amplitude [AU]')
title(['Synapse i1 = ',num2str(i1)])
legend('T_p','T_d','P(t)','W')
grid on

figure
plot(t,Tp_i2,'b','LineWidth',2); hold on
plot(t,Td_i2,'r','LineWidth',2)
plot(t,P_t,'g','LineWidth',2)
plot(t,W_i2,'k','LineWidth',2)

xlabel('Time [s]')
ylabel('Amplitude [AU]')
title(['Synapse i2 = ',num2str(i2)])
legend('T_p','T_d','P(t)','W')
grid on

%plateau potential V(x)
beta = 1.0;

x = v*t; %current position
V = zeros(length(t),1);

for k = 1:length(t)
    
    % R_i(t_k) za sve sinapse
    R_now = alpha * exp(-((v*t(k) - x0)/sigma).^2);
    
    % V(t_k) = beta * suma R_i * W_i
    V_t(k) = beta * sum(R_now .* W_vals(k,:));
    
end

% plotting V(x)

figure
plot(x,V_t,'LineWidth',2)
xlabel('Position x')
ylabel('V(x)')
title('Postsynaptic potential V(x)')
grid on


function dydt = trace_model(t,y,N,x0,alpha,sigma,v,...
                            eta_p,tau_p,Tmax_p,...
                            eta_d,tau_d,Tmax_d,...
                            gamma,tau_I,tP)

    Tp = y(1:N);
    Td = y(N+1:2*N);
    W  = y(2*N+1:3*N);

    R = alpha * exp(-((v*t - x0)/sigma).^2)';

    dTp = (-Tp + eta_p*R.*(Tmax_p - Tp))/tau_p;
    dTd = (-Td + eta_d*R.*(Tmax_d - Td))/tau_d;

    % global instructive signal
    if t < tP
        P = 0;
    else
        P = gamma * exp(-(t - tP)/tau_I);
    end

    % synaptic weight
    dW = (1 - W).*Tp*P - W.*Td*P;

    dydt = [dTp; dTd; dW];
end