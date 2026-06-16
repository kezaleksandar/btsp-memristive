%modeling R(v*t) inputs

%constants
alpha = 7.5;  %[V]
sigma = 0.9/(3*sqrt(2)); %[m]
v = 0.5; %constant velocity, [m/s]

%symbolic variables
syms t

%current position
x = v*t;

%assume track length 2 meters, divided into N segments of equal length
N = 10; %number of presynaptic inputs
x0 = linspace(0, 2, N); % array of equidistant centers of each segment[m]

%defining R(x) = R(v*t) firing rates 
R = sym(zeros(1, N)); 
for i = 1:N
    R(i) = alpha*exp(-((x - x0(i))/sigma)^2);
end

hold on
for i = 1:N
    fplot(R(i), [0 4]);
end
xlabel('x [m]')
ylabel('R(v*t) [AU]')
hold off
