%% ģ����˷�����������PSK�����ź�

clc;clear;

Ts = 1; %��Ԫ����(ÿ����Ԫ����Ϊ1s)
N_sample = 1000;  %ÿ����Ԫ�Ĳ�������
N = 200; %��Ԫ����
dt = Ts/N_sample; %������֮���ʱ����
fc = 10;  %�ز�Ƶ��

SimTime = N*Ts;       % �����źŵ���ʱ�䳤��
Fs = 1/dt;            % ����Ƶ��
df = 1/SimTime;       % ����Ƶ�ʷֱ���
f = -Fs/2:df:Fs/2-df;     % ����Ƶ��ʸ����Ƶ��ͼ�ĺ����꣩

%�õ��ز��ź�
t = 0:dt:(N*N_sample-1)*dt;

Carr = sin(2*pi*fc*t);

% ��������������
baseC = randint(1,N); 
baseC1 = 2*baseC-1;  %���˫������

% ����˫���Բ���������źŲ���
baseD = zeros(N_sample,N);
for i=1:N_sample
  baseD(i,:) = baseC1;
end;
baseD = reshape(baseD,1,N_sample*N);

% ����PSK����
PSK_Sig = baseD.*Carr;

%��ͼ
M1 = max(baseD);
m1 = min(baseD);
subplot(311);
plot(t,baseD,'LineWidth',1.5);grid on
axis([0 8 m1-0.1 M1+0.1]);title('˫���Զ����ƻ����ź�');

M1 = max(Carr);
m1 = min(Carr);
subplot(312);
plot(t,Carr,'LineWidth',1);grid on
axis([0 8 m1-0.1 M1+0.1]);title('�ز��ź�');

M1 = max(PSK_Sig);
m1 = min(PSK_Sig);
subplot(313);
plot(t,PSK_Sig,'LineWidth',1);grid on 
axis([0 8 m1-0.1 M1+0.1]);title('˫������2ASK�����ź�');

%����Ƶ�ײ���ͼ
figure(2)
fmt = fft(baseD);        % ��ʱ���źŽ���FFT�任��������Ƶ��
fmt = fftshift(fmt);
fmt = abs(fmt);

subplot(211)
plot(f,fmt);grid on;
maxF = max(fmt);
minF = min(fmt);
axis([-5 5 minF maxF]);
title('˫���Ի����ź�Ƶ��');

fmt = fft(PSK_Sig);        % ��ʱ���źŽ���FFT�任��������Ƶ��
fmt = fftshift(fmt);
fmt = abs(fmt);
maxF=max(fmt);
minF=min(fmt);
subplot(212)
plot(f,fmt);grid on;
axis([-25 25 minF+20 maxF+20]);
title('PSK�����ź�Ƶ��');