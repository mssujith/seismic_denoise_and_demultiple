clear
t_start = cputime;

%loading the given stack
stack = load("FK.txt");
temp = stack;


%plotting data in time domain
subplot(2,2,1)
imagesc(stack)
colormap('jet')
colorbar
xlabel('offset')
ylabel('time')
set(gca,'XAxisLocation','top')
title('before removing linear event (x-t domain)')

%2D Fourier transform
STACK = fft2(stack);


%plotting data in f-k domain
subplot(2,2,2)
imagesc(abs(STACK))
colorbar
xlabel('wavenumber')
ylabel('frequency')
set(gca,'XAxisLocation','top')
title('before removing the linear event (f-k domain)')

%removing linear event
STACK([1:100],:) = 0;
STACK([2401:2500],:) = 0;

%plotting updated data in f-k domain
subplot(2,2,4)
imagesc(abs(STACK))
colorbar
xlabel('wavenumber')
ylabel('frequency')
set(gca,'XAxisLocation','top')
title('after removing the linear event (f-k domain)')

%inverse 2D Fourier transform
stack = ifft2(STACK);

stack = stack .* (temp ./ abs(temp+10^-10));

%plotting updated data in time domain
subplot(2,2,3)
imagesc(abs(stack))
colorbar
xlabel('offset')
ylabel('time')
set(gca,'XAxisLocation','top')
title('after removing linear event (x-t domain)')

cpu_time = cputime - t_start;
