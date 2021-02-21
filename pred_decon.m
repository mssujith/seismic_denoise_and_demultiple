clear
colormap(gray)
t_start = cputime;

%loading the given stack
traces = load("Decon.txt");

%traces([105:110],:) = .6;
%traces([305:310],:) = .4;
%traces([505:510],:) = .3;
%traces([705:710],:) = .2;

traces1 = traces([201:500],:);

[t,x] = size(traces);

%prediction after alpha=1
pred = traces([202:501],:);


%wiener filter
i = traces1;  %input signal
d = pred;  %desired signal

m = zeros(300,x);
for k = 1:x
    [m1,w1] = wiener_filter(i(:,k),d(:,k));
    m(:,k) = m1;    %filter coefficients
end

%extrapolating the filter coefficients
m = [m;zeros(2200,21)];

%alpha time delayed traces
traces2 = [zeros(1,21);traces([1:2499],:)];

%output = multiples
mult = abs(ifft(fft(m) .* fft(traces2)));
mult = (mult .* max(abs(traces))) .* (traces ./ (abs(traces+10^-10)));

%primary reflections
prim = traces./max(abs(traces([500:end],:))) - mult./max(abs(mult));
prim = prim .* max(abs(traces([500:end],:)));

%prim = traces - mult;

%plotting
colormap('gray')
subplot(1,3,1)
imagesc(traces)
colorbar
xlabel('offset')
ylabel('time')
set(gca,'XAxisLocation','top')
title('Given data')

subplot(1,3,2)
imagesc(mult)
colorbar
xlabel('offset')
ylabel('time')
set(gca,'XAxisLocation','top')
title('Multiple reflections')

subplot(1,3,3)
imagesc(prim)
colorbar
xlabel('offset')
ylabel('time')
set(gca,'XAxisLocation','top')
title('Primary reflections')


cpu_time = cputime - t_start;
