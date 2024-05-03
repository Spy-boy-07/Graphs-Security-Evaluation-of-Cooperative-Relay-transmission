% Parameters
gamma_s = 12; % SNR in dB
sigma_sd2 = 0.5; 
sigma_sr2 = 2;
sigma_rd2 = 2;

% MER range
mer_db = -5:1:25;
mer = 10.^(mer_db/10);

% Number of relays
M = [2, 4, 8];

% Ergodic secrecy capacity
ergodic_secrecy_capacity = zeros(length(mer_db), length(M) + 1);

% Direct transmission
for i = 1:length(mer_db)
    c_s = log2(1 + gamma_s * mer(i)) - log2(1 + gamma_s / mer(i));
    ergodic_secrecy_capacity(i, 1) = max(c_s, 0);
end

% Cooperative relay selection
for j = 1:length(M)
    for i = 1:length(mer_db)
        c_s = log2(1 + gamma_s * (sigma_sd2 * sigma_sr2 * M(j)) / (sigma_sd2 + sigma_sr2 + sigma_rd2 / M(j))) ...
              - log2(1 + gamma_s / mer(i));
        ergodic_secrecy_capacity(i, j+1) = max(c_s, 0);
    end
end

% Plot
figure;
plot(mer_db, ergodic_secrecy_capacity(:, 2), 'r-o', ...
     mer_db, ergodic_secrecy_capacity(:, 3), 'c-^', ...
     mer_db, ergodic_secrecy_capacity(:, 4), 'm-s');
xlabel('Main-to-Eavesdropper Ratio (dB)');
ylabel('Secrecy Capacity (bits/s/Hz)');
legend('Relay selection w. M = 2', 'Relay selection w. M = 4', 'Relay selection w. M = 8');
grid on;

