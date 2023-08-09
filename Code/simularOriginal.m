function simularOriginal(quantidadePortadora,intervaloPiloto,tamanhoPrefixoCiclico,tamanhoCanal,iteracoes,signalNoiseRatio_v)
% Simula pelo arquivo base, o qual foi usado para ser adaptado. Foi
% necessário adaptações mínimas sobre ele para que fizesse a configuração
% de alguns parâmetros simultaneamente nos dois algoritmos de simulação.

% in this Mfile, I want to investigate the performance of LSE algorithm in
% OFDM channel estimation
%
% for further information see the 
%       [Xiaodong Cai and Georgios B. Giannakis,
%        Error Probability Minimizing Pilots for
%        OFDM with M-PSK Modulation over Rayliegh-Fading
%        Channels, IEEE Transactions on Vehicular 
%        technology, vol. 53, No. 1, pp 146-155, Jan. 2004.]
    
    % parameter definition
    N  = quantidadePortadora;           % total number of subchannels
    %P  = quantidadePiloto; %N/8;         % total number of Pilots
    %S  = N-P;           % totla number of data subchannels
    GI = tamanhoPrefixoCiclico;           % guard interval length
    M  = 2;%4;             % modulation
    pilotInterval = intervaloPiloto;%ceil(N/P);  % pilot position interval
    L  = tamanhoCanal;            % channel length
    nIteration = iteracoes;    % number of iteration in each evaluation
    
    SNR_V = signalNoiseRatio_v;   % signal to noise ratio vector in dB
    ber = zeros(1,length(SNR_V));   % initializing bit error rate
    
    % Pilot Location and strength
    Ip = [1:pilotInterval:N];       % location of pilots
    Is = setxor(1:N,Ip);            % location of data
        
    Ep = 1;                        % energy in pilot symbols in comparison 
                                        % to energy in data symbols
    
    % fft matrix
    F = exp(2*pi*sqrt(-1)/N .* meshgrid([0:N-1],[0:N-1])...
        .* repmat([0:N-1]',[1,N]));
    
    
    for( i = 1 : length(SNR_V))
        SNR = SNR_V(i);
        for(k = 1 : nIteration)
            % freq: Y=X.H + w=0
            % generating random channel coefficients
            h(1:L,1)  =     random('Normal',0,1,L,1) + j * random('Normal',0,1,L,1);  
            h  = h./sum(abs(h));    % normalization    
            
            % Tr Data
            TrDataBit = randi(M-1,N,1);%gera N valores de 0 ate M-1 em uma coluna (vetor)
            TrDataMod = pskmod(TrDataBit,M);%qammod(TrDataBit,M);
            TrDataMod(Ip) = Ep * TrDataMod(Ip);
            TrDataIfft = ifft(TrDataMod,N);
            TrDataIfftGi = [TrDataIfft(N- GI + 1 : N);TrDataIfft];
    
    
            % tx Data    
            TxDataIfftGi = filter(h,1,TrDataIfftGi);    % channel effect CONVOLUCAO CIRCULAR!
            % adding awgn noise
            TxDataIfftGiNoise = awgn(TxDataIfftGi ...
                , SNR - db(std(TxDataIfftGi))); % normalization to signal power
    
            TxDataIfft  = TxDataIfftGiNoise(GI+1:N+GI);
            TxDataMod   = fft(TxDataIfft,N);
    
            % Channel estimation
            Spilot = TrDataMod(Ip); % trnasmitted pilots
            Ypilot = TxDataMod(Ip); % received pilots
    
            G = (Ep * length(Ip))^-1 ...
                * ctranspose(sqrt(Ep)*diag(Spilot)*ctranspose(F(1:L,Ip)));
    
            hHat = G*Ypilot;    % estimated channel coefficient in time domain
    
            TxDataBit   = pskdemod(TxDataMod./(fft(hHat,N)),M);%qamdemod(TxDataMod./(fft(hHat,N)),M);
    
            % bit error rate computation
            [nErr bErr(i,k)] = symerr(TxDataBit(Is),TrDataBit(Is));
        end
    end
    
    snr = SNR_V';
    bErr = mean(bErr')';

    writetable(table(snr,bErr),strcat("../Saida/Script Original x Script Adaptado/Script Original.txt"));

end