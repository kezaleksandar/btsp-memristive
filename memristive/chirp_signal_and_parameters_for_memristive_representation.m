clc
close all
t1 = 0:1/1e3:2;
t2 = 2:1/1e3:4;
fo = 1e-3;
f1 = 50;
y1 = chirp(t1,fo,2,f1,'quadratic', 0, 'concave'); 
y2 = flip(y1);
t=[t1 t2];
y = [y1 y2];
z1 = zeros(1,length(y1));
w1 = zeros(1,length(y1));
Im = 2e-3;
w_high = Im;
w_low = 0;
for i=1:length(y1)
    if y1(i)>=0.8 
        z1(i)=w_high;
    else
        z1(i) = w_low;
    end
end
for i=1:(length(z1)-1)
    if z1(i)==w_low && z1(i+1)==w_high
            w1(i)=w_low;w1(i+1)=w_high;

    end
end
w2 = -flip(w1); %ovde treba - flip ne samo -
z2 = -flip(z1);
w = -[w1 w2];
q0 = 1e-4/5;
z = [z1 z2];
ww = timeseries(w,t);
figure(1)
%{
subplot(3,1,1)
plot(t,y)
subplot(3,1,2)
plot(t,z)
subplot(3,1,3)
plot(t,w)
xlabel('time [s]');
ylabel('current [A]');
%}

plot(t,w)
xlabel('time [s]');
ylabel('current [A]');
figure(2)
spectrogram(y,hann(128),120,128,1e3,'yaxis')

sim_source = [t' w'];