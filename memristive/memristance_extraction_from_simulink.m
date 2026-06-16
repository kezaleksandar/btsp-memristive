clc
close all
vreme=xout.time;
xi=xout.signals(2).values;
Ra = get_param("firing_rate_antiparallel_synapse_weight_chirp/Memristor", "value@Ra");
Rb = get_param("firing_rate_antiparallel_synapse_weight_chirp/Memristor", "value@Rb");

M = (1-xi)*Ra+xi*Rb;

figure;
plot(vreme, M);
xlabel('time [s]');
ylabel('memristance [ohm]');

