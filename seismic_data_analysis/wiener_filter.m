%function to calculate wiener filter coefficients(m) and estimated signal(w)
%i is the input signal and d is the desired signal
%input signals must be in x-t domain

function [m,w] = wiener_filter(i,d)
    l = length(i);
    
    %Fourier transform
    I = fft(i);
    D = fft(d);
    
    %auto correlation of i
    R = I .* conj(I);
    r = abs(ifft(R));
    %cross correlation of d with i
    G = D .* conj(I);
    g = abs(ifft(G));
    
    %F matrix from auto correlation of i
    F = zeros(l);
    for p = 1:l
        F(p,[p:end]) = r([1:end-p+1]);
    end
    
    for p = 1:l
        for q = 1:p
            F(p,q) = F(q,p);
            %F(q,p) = F(p,q);
        end
    end
    
    %{
    %svd decomposition of F
    [U,S,V] = svd(F);
    
    S1 = S;
    S1(S1<10^-5) = [];
    l1 = length(S1);
    V1 = V(:,[1:l1]);
    U1 = U(:,[1:l1]);
    
    %pseudoinverse
    F_dagger = V * inv(S) * U';
    
    %filter coefficients
    m = F_dagger * g;
    %}
    
    %filter coefficients
    m = F\g;
    
    %estimated wavelet
    W = fft(m) .* I;
    w = abs(ifft(W)) .* (d ./ abs(d+10^-10));
    w = w ./ max(abs(w));
    
end
