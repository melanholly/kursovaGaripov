%% Inicializirane
T0=1;
N=1000;
z = tf([0 1],1,T0,'variable','z^-1');
n=1;
G0=0.5*z/(1-0.8*z); % osnovna predavatelna funkciq, koqto shte ocenqvame
m=2;
A=[1 0.8];
B=[0 0.5];
C=(0.0012+0.0002*z-0.001*z*z)/(0.5-0.9656*z+0.4656*z*z);% kontrolera
tmp=C.num{1,1}/.5;
tmp=tmp(tmp~=0);
Q=tmp;
tmp=C.den{1,1}/.5;
tmp=tmp(tmp~=0);
P=tmp;
H0=(1-1.56*z+1.045*z*z-0.3338*z*z*z)/(1-2.35*z+2.09*z*z-0.6675*z*z*z); %filtura
r=idinput(1000); % pravim si 1000 tochkov unikalen signal
% r=linspace(1,1,1000)';
t=1:1000;
R2=[t',r];
% static_noise=rand(N,1)*1e8;
static_noise = 1.0e+07 *[, 6.6270, 6.2155, 0.9660, 7.4107, 8.5447, 6.7709, 7.0850, 0.9670, 3.8586, 0.5423, 7.8956, 1.8573, 3.4295, 0.8032, 8.1865, 1.6084, 7.8049, 9.7011, 3.7617, 8.0373, 1.4923, 8.8094, 4.9563, 1.5577, 6.8044, 6.1572, 6.0682, 7.7108, 2.7340, 9.7515, 4.5337, 4.2968, 4.9923, 0.5773, 4.4273, 2.3633, 1.9882, 5.1188, 6.3921, 1.3692, 2.6361, 7.1837, 5.0085, 1.6143, 3.6276, 1.2070, 7.1931, 2.7257, 6.7910, 6.7682, 2.6115, 4.8288, 4.8248, 4.0659, 8.6911, 8.7485, 3.6472, 5.8476, 8.0545, 7.4723, 2.0336, 1.8420, 2.4627, 8.7311, 4.3289, 2.9606, 4.3410, 5.8753, 7.1495, 1.7808, 8.8981, 3.5446, 9.0139, 5.7334, 4.5146, 4.7874, 7.3668, 5.8613, 7.2670, 3.9233, 8.8616, 9.6027, 5.7802, 3.2474, 0.4225, 3.9656, 7.3018, 6.0697, 7.1899, 2.5100, 0.5334, 7.5905, 7.8593, 0.8463, 7.6615, 7.7985, 7.9170, 8.1448, 5.9206, 4.9951, 5.8030, 1.2466, 7.9098, 2.6755, 7.8036, 8.6662, 8.0784, 3.4129, 2.1671, 1.0631, 8.0343, 5.1221, 4.4735, 5.8474, 3.1250, 2.0410, 6.3774, 4.8549, 1.0266, 0.6337, 7.2210, 2.4237, 7.0192, 5.4698, 7.6925, 7.2912, 5.6078, 2.6875, 3.4634, 7.6405, 5.6040, 1.1503, 5.9471, 4.1651, 4.2842, 1.2476, 3.4050, 3.6335, 6.0387, 6.7393, 2.1510, 1.5070, 1.2317, 2.5743, 0.3481, 8.5018, 7.2752, 4.1293, 1.4606, 5.4768, 8.0743, 3.6331, 4.7330, 4.4875, 7.1228, 8.0815, 2.2137, 2.9886, 9.8031, 7.0416, 4.0064, 3.7693, 3.3200, 7.3330, 5.4246, 5.5284, 1.3780, 6.8438, 2.8787, 9.2004, 1.2372, 7.5687, 4.4367, 8.8817, 8.4930, 6.4957, 9.7320, 8.6397, 4.7330, 9.0671, 3.2527, 6.3684, 9.3571, 4.0407, 8.8574, 6.1703, 0.9025, 7.1962, 1.2666, 8.5320, 0.5089, 3.6184, 8.7328, 5.1526, 5.8703, 7.0077, 8.6298, 2.0979, 3.8527, 8.0069, 4.9623, 0.9919, 3.9545, 8.9774, 1.5247, 7.6356, 9.7788, 1.5638, 9.0533, 3.5462, 6.9133, 0.7258, 3.5731, 8.5859, 4.4968, 1.0495, 5.1618, 4.2129, 7.8177, 9.1531, 6.7743, 5.9166, 5.0176, 8.6140, 3.6759, 5.8825, 0.5906, 7.3791, 3.9538, 2.1676, 1.6259, 5.9619, 1.3764, 0.0986, 8.2504, 1.8694, 0.7940, 0.9097, 7.5451, 9.2477, 1.0855, 6.2874, 8.2644, 0.8859, 0.1959, 8.9935, 4.8290, 8.1430, 9.2743, 1.3830, 1.4249, 8.7372, 3.0971, 1.7109, 8.4111, 4.6708, 5.3539, 9.8625, 1.1149, 6.3710, 1.3115, 9.0255, 9.1928, 5.5523, 3.2680, 9.1307, 4.3397, 7.8334, 2.3202, 2.4734, 0.6117, 5.3463, 4.8716, 7.9998, 6.7719, 6.9762, 3.5583, 5.5557, 5.3101, 3.8421, 7.5125, 6.7983, 5.9110, 0.7172, 1.5022, 3.2138, 8.7315, 7.8986, 6.7342, 4.0020, 9.5375, 8.5241, 3.8902, 6.8048, 4.6728, 1.5084, 2.4041, 2.1821, 5.8201, 3.2320, 0.2650, 6.0309, 5.4633, 6.0561, 4.8694, 9.9679, 3.1009, 2.7151, 2.0515, 8.6058, 1.2839, 8.1759, 8.5958, 4.9739, 8.7241, 7.1058, 6.2965, 6.3150, 9.2166, 9.8346, 6.6953, 1.4731, 0.3341, 2.1420, 3.3471, 5.5837, 3.9803, 0.4866, 5.0074, 4.4456, 3.0801, 8.5967, 5.3969, 3.5433, 0.8579, 4.0663, 4.6435, 2.2237, 0.6953, 7.2301, 2.1338, 2.9701, 5.7600, 7.6147, 8.2126, 4.8600, 4.6992, 5.0051, 7.5793, 2.9339, 8.1408, 7.0290, 0.0519, 1.5770, 6.5903, 8.5816, 3.9350, 6.9201, 9.8108, 9.1856, 5.1541, 6.3368, 3.8017, 0.9078, 2.3153, 0.8410, 9.8784, 4.6189, 7.6591, 7.4729, 4.7003, 4.4824, 8.0379, 5.9951, 4.2688, 3.1219, 3.0969, 7.1896, 6.8724, 5.5330, 8.7911, 0.6464, 8.9130, 6.2535, 0.6043, 9.8169, 8.9511, 3.0307, 5.4320, 3.4812, 3.6516, 5.1312, 8.0168, 4.7663, 9.9054, 3.7312, 8.4706, 0.3403, 7.7662, 3.3251, 2.6027, 6.4937, 9.6625, 5.8418, 8.6683, 5.2190, 4.1220, 5.3998, 2.8684, 6.8018, 4.0696, 1.3473, 5.8194, 1.2376, 9.4192, 3.2300, 7.2101, 8.3036, 0.6259, 2.3721, 6.0678, 8.2940, 6.8817, 0.4746, 6.8414, 8.9808, 0.5780, 0.9748, 3.9799, 8.9431, 6.7060, 8.2444, 8.6854, 6.3040, 5.7247, 4.5801, 4.4241, 0.8561, 0.2919, 8.0720, 6.7451, 2.7876, 1.9292, 3.9383, 6.3239, 2.2615, 0.3984, 0.8912, 3.2342, 6.0697, 4.2809, 8.9861, 5.2472, 8.3048, 5.1751, 3.9629, 2.0639, 7.2147, 3.6531, 5.5446, 6.3940, 7.5374, 4.5107, 0.2078, 1.9656, 2.5958, 5.1632, 2.4866, 6.3715, 6.9333, 7.6064, 2.6106, 1.9535, 8.4017, 2.1277, 7.2041, 5.9771, 1.5019, 5.7301, 4.0168, 3.3943, 5.4935, 8.5590, 4.5375, 3.5462, 4.1443, 3.2171, 9.0803, 9.4982, 7.0513, 0.9271, 8.0913, 2.7091, 6.8682, 9.1336, 0.9372, 2.9696, 7.7012, 5.1897, 6.1710, 1.1918, 5.6055, 9.5647, 7.2743, 9.2332, 0.5331, 7.2533, 0.8222, 7.2374, 0.4601, 5.8546, 3.0119, 4.1461, 9.5860, 1.9847, 4.9399, 0.8944, 8.4081, 6.4445, 0.0758, 9.5810, 2.2399, 2.2978, 7.7808, 9.9230, 5.4685, 1.0257, 0.5616, 2.2646, 3.0954, 8.1221, 8.5590, 1.4431, 2.1304, 0.2668, 3.3692, 6.7633, 9.5531, 0.5002, 7.1166, 2.3165, 1.6001, 7.4378, 9.7101, 3.7025, 6.5521, 6.8156, 1.2667, 9.6753, 2.4246, 5.3276, 8.3144, 6.8230, 5.1714, 4.0977, 1.4510, 2.4545, 6.9887, 4.1834, 1.5232, 8.1338, 0.9607, 8.7328, 5.1547, 1.6371, 7.4584, 4.3024, 1.5769, 0.8501, 8.6395, 7.7714, 2.6702, 2.8465, 6.0699, 0.4732, 8.3555, 9.6881, 7.5010, 9.2423, 1.0700, 9.0917, 8.1958, 6.4361, 9.9884, 2.1479, 9.9074, 0.2253, 3.9522, 5.6303, 5.6388, 4.6944, 4.4356, 2.0157, 1.9618, 8.5223, 6.9114, 3.7886, 1.9025, 2.5562, 2.9693, 8.9581, 9.9096, 0.8399, 3.4704, 0.8849, 6.3064, 2.5184, 4.2590, 5.0912, 2.7846, 5.3828, 8.0252, 1.2227, 7.5047, 4.7991, 9.9887, 4.6701, 5.4111, 0.8827, 9.6990, 6.2237, 4.4977, 9.1004, 9.0643, 1.2649, 2.5712, 6.0338, 1.8814, 2.6572, 1.7381, 5.0851, 6.2658, 4.1456, 0.9389, 3.4982, 5.2913, 9.9241, 1.0561, 6.3054, 6.0403, 7.7460, 4.6881, 1.4612, 2.1722, 8.7144, 9.4232, 1.0712, 5.0318, 3.0481, 7.7599, 7.2762, 2.6804, 7.6850, 8.4139, 4.0273, 9.4038, 0.1557, 6.1408, 1.5876, 3.8119, 4.2477, 6.8117, 3.8625, 2.5398, 7.6890, 1.8214, 9.9852, 3.2124, 1.2066, 7.7714, 9.6225, 3.9239, 6.7561, 2.9686, 2.2925, 8.4068, 3.8984, 6.2238, 8.1504, 9.5702, 4.9567, 8.4377, 5.4422, 6.0190, 4.4362, 6.8193, 6.7283, 9.1890, 6.1300, 2.3276, 1.4340, 1.7316, 7.5300, 0.7546, 0.7397, 2.5497, 1.5413, 1.9045, 6.4705, 7.8824, 0.0824, 9.8365, 0.0785, 8.1152, 1.0875, 9.1995, 0.2921, 6.0731, 7.2158, 0.7808, 7.2439, 9.1647, 6.9782, 8.8714, 6.0233, 9.7687, 8.0855, 9.6774, 4.4078, 7.0002, 6.0918, 3.9323, 1.3299, 6.4927, 5.5788, 2.9592, 0.4913, 7.0780, 1.2699, 8.9876, 0.5556, 2.6402, 0.7789, 9.3176, 0.0733, 1.2714, 9.9914, 3.2291, 0.2141, 1.8299, 2.2422, 9.5577, 1.3193, 3.4974, 9.2067, 3.9570, 8.7790, 5.9999, 5.2380, 0.9244, 9.5632, 5.3769, 8.1103, 5.4209, 6.9966, 9.8627, 0.9013, 9.4938, 0.4866, 9.4965, 1.9311, 2.0163, 3.3818, 0.2318, 3.6442, 4.8846, 1.7657, 8.3093, 0.2494, 6.6733, 7.2774, 0.5753, 6.0715, 0.0884, 6.5108, 4.4143, 6.1048, 1.5296, 1.4585, 9.7587, 7.2981, 0.2061, 3.2221, 3.6983, 2.0303, 4.9167, 1.5089, 8.4443, 5.2984, 5.9715, 3.1358, 3.4264, 4.5908, 0.6617, 2.9478, 6.8927, 1.4616, 9.7860, 9.9019, 1.4638, 4.2197, 6.9134, 6.0228, 9.0566, 1.6427, 3.4583, 4.7493, 3.4874, 5.7706, 5.6085, 9.6141, 4.8425, 4.7472, 5.5888, 6.9939, 9.0007, 2.8225, 7.0297, 6.2267, 2.8673, 9.0854, 7.8493, 9.3651, 8.9175, 3.3592, 6.1910, 4.6553, 1.2134, 9.3618, 5.2867, 9.1212, 2.3837, 3.2302, 6.4209, 3.9003, 0.5277, 7.8891, 6.6778, 6.1717, 0.8143, 2.6684, 6.0149, 9.5410, 2.3493, 1.7779, 3.9876, 4.2541, 6.0145, 0.9155, 9.5233, 1.8756, 9.7281, 3.6072, 9.7725, 1.4085, 2.5286, 1.8347, 4.1153, 4.8847, 7.9363, 5.7515, 4.7571, 5.3806, 0.4017, 4.6155, 7.1746, 5.9737, 9.7104, 6.6256, 1.5164, 1.2969, 9.1023, 9.1982, 1.3869, 0.4932, 2.5731, 9.4120, 3.9778, 3.8396, 7.6309, 1.5931, 8.4838, 3.3497, 6.3337, 0.3123, 6.2998, 7.7826, 4.4011, 1.0866, 0.8344, 6.2482, 3.1411, 8.4946, 0.8059, 7.5961, 6.9357, 7.0386, 1.6210, 3.2769, 7.5211, 1.1566, 8.6750, 5.5257, 8.7150, 9.7511, 6.1863, 2.7538, 0.1224, 9.5538, 6.9502, 1.5139, 6.3449, 2.0436, 9.3606, 2.2744, 1.5110, 9.8646, 9.6215, 8.6044, 4.3224, 4.7935, 8.1483, 4.2026, 0.0620, 0.8465, 4.5323, 9.6269, 2.9377, 3.3296, 7.2063, 1.4376, 7.5631, 8.2510, 6.7324, 2.1167, 9.9693, 8.7192, 8.0660, 4.9758, 5.2867, 2.2591, 5.2281, 2.2576, 3.2264, 2.1590, 4.7814, 4.9840, 8.3352, 3.4603, 0.4369, 8.0430, 6.8100, 8.2389, 1.3254, 0.5536, 8.3952, 7.8920, 9.8912, 0.2838, 7.5597, 1.6501, 3.0699, 3.6394, 4.2626, 9.1193, 7.6302, 6.6157, 8.4534, 0.6210, 0.0670, 0.6730, 0.7972, 8.9279, 2.9939, 1.1692, 1.4921, 7.5970, 4.0708, 6.2779, 0.7609, 7.0817, 8.9709, 2.5327, 9.0036, 1.6124, 8.9833, 6.8973, 9.6866, 4.0823, 9.2315, 3.2763, 0.5393, 6.3303, 1.9626, 0.2595, 5.8064, 5.0993, 6.3641, 8.1561, 7.9172];
seed=static_noise(1);
scale = 0.008; % snr ~15dB
sim('data_generator_plant');
signal=signal_and_noice(:,1);
noice=signal_and_noice(:,2);
disp(['SNR: ',num2str(snr(signal,noice))]);
closed=feedback(G0*C,1);
sample_data=iddata(signal_and_noice(2:end,1),r,T0);

%% Harakteristiki na izsledvanite modeli
figure,step(G0,closed),legend toggle;
figure, bode(G0,closed),legend toggle;
figure,step(H),legend toggle;
figure,bode(H),legend toggle;
savefigs('images/harakteristiki-na-obekta-');
%% Poluchavane na modelite
arx_model=arx(sample_data,[1 1 1]);
figure,resid(arx_model,sample_data);
% figure,compare(sample_data,arx_model);
figure, step(G0,arx_model);
display(tf(arx_model));
%% iv4
iv4optimalen=iv4(sample_data,[1 1 1]);
figure,resid(iv4optimalen,sample_data);
% figure,compare(sample_data,iv4optimalen);
figure, step(G0,tf(1000*iv4optimalen.b,iv4optimalen.a,T0,'variable','z^-1'));
display(tf(1000*iv4optimalen.b,iv4optimalen.a,T0,'variable','z^-1'));
%po-dobre e da se izpolzva ivx kato metod za identifikaciq za da moje da se
%izpolzvat instrumentalni promenlivi zadavani v aftorska funkciq. ne tezi,
%koito izchislqva IV4 algorituma na matlab.
%% izpolzvame zadanieto kato instrumenti - variant na M1 
close all;
i=1;
instruments=[zeros(1,i),  r(i+1:end)']';
ivx_model=ivx(sample_data,[1 1 1],instruments); %neoptimalen nachin za
%presmqtane no e nachin sega trqbav da oprabotq vektora na istrumentite po
%nachina deto e opisan v statiite
% figure,resid(ivx_model,sample_data);
% figure,compare(sample_data,iv4optimalen);
figure, step(G0,tf(170*ivx_model.b,ivx_model.a,T0,'variable','z^-1'));
display(tf(ivx_model.b,ivx_model.a,T0,'variable','z^-1'));
%% closed-loop basic IV method
titas=0;
monteCarlo=50;
rb=2*n;
L=1;
for intr=1:monteCarlo
    disp(intr);
    seed=static_noise(intr);
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*fi';
        tempsum2=tempsum2+fir*y(t);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    titas=titas+tempsum^-1*tempsum2;
end
titas=titas/monteCarlo;
result=tf([0 titas(2)],[1 titas(1)],T0,'variable','z^-1');
disp(monteCarlo);
display(titas);
display(result);
step(G0,result);
%     0.5 z^-1
%   ------------
%   1 - 0.8 z^-1
% 
% result =
%  
%       0.4799 z^-1
%   ---------------
%   1 - 0.8122 z^-1
%  
% Sample time: 1 seconds
% Discrete-time transfer function.
% 
% 
% titas =
% 
%    -0.8122
%    -0.4799
%% Closed-loop extended IV method
titas=0;
monteCarlo=20;
rb=2*n;
L=1;
for intr=20:monteCarlo+20
    disp(intr);
    seed=static_noise(intr);
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*prefilter(fi,L)';
        tempsum2=tempsum2+fir*prefilter(y(t),L);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    titas=titas+tempsum^-1*tempsum2;
end
titas=titas/monteCarlo;
result=tf([0 titas(2)],[1 titas(1)],T0,'variable','z^-1');
disp(monteCarlo);
display(titas);
display(result);
step(G0,result);
%     0.5 z^-1
%   ------------
%   1 - 0.8 z^-1
% titas =
% 
%    -0.7300
%    -0.5252
% 
% 
% result =
%  
%      0.5252
%   -------------
%   1 - 0.73 z^-1
%% Tailor-made IV identification (M1)
titas=0;
monteCarlo=100;
n=1;
F=1000*eye(length(r));
xmin=100000;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    ivx_model=ivx(sample_data,[1 1 1],F*[0 0 r(3:end)']');
    titas=titas+[ivx_model.a(n+1:end);ivx_model.b(n+1:end)];
end
titas=titas/monteCarlo;
result=tf([0 100*titas(2)],[1 titas(1)],T0,'variable','z^-1');
display(titas);
display(result);
step(G0,result);
% titas =
% 
%    -0.8135
%    -0.5346
% 
% 
% result =
%  
%     0.5346 z^-1
%   ---------------
%   1 - 0.8135 z^-1
%% BELS method
N=1000;
tmp=C.num{1,1}/.5;
tmp=tmp(tmp~=0);
Q=tmp;
tmp=C.den{1,1}/.5;
tmp=tmp(tmp~=0);
P=tmp(2:end);
ps=[1 P];
qs=[Q];
Qc=sylvester_bels(qs);
Pc=sylvester_bels(ps);
Pcc=[Pc;zeros(1,length(Pc(1,:)))];
M=[Pc Qc;zeros(size(Pcc)),Pcc];
titas=0;
monteCarlo=100;
N=1000;
n=1;
rb=m+n;
Q=1000*eye(n);
L=eye(n);
xmin=100000;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=-signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*L*fi';
        tempsum2=tempsum2+fir*L*y(t);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    xc=tempsum^-1*tempsum2;
    x=xc'*Q*xc;
    if(x<xmin)
        xmin=x;
        titas=xc;
    end
end
result=tf([0 -titas(2)],[1 titas(1)],T0,'variable','z^-1');
display(titas);
display(result);
step(G0,result);
% titas =
% 
%    -0.2901
%    -0.2470
% 
% 
% result =
%  
%     0.247 z^-1
%   ---------------
%   1 - 0.2901 z^-1
%% dalin
Wd=result
d=1;
[ Bin,Bout,Bplus,Bminus ] = bsbu([Wd.num{1}(2:end)]);

% proektirane na regulator na dalin
Ad=Wd.den{1};
Tsau=33;
[ Q,P ] = dalin_nomin(Bplus,Bminus,Ad,d,Tsau,T0);
Wd=G0;
sim('model',400);
h=pilot(ScopeData,d,T0,Tsau);
%%
%% Closed-loop extended IV method
tita=0;
titata=0;
monteCarlo=5;
rb=2*n;
Q=1000*eye(n);
L=1;

for intr=1:monteCarlo
    xmin=1e8;
    disp(intr);
    seed=static_noise(intr);
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=signal;
    u=signal_and_noice(:,3);

    tempsum=0;
    tempsum2=0;
    tempsum3=0;
    tempsum4=0;

    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        z=fir;
        tempsum=tempsum+z*fi';
        tempsum2=tempsum2+z*y(t);
        tempsum3=tempsum3+z*L*fi';
        tempsum4=tempsum4+z*L*y(t);
        
        tempsum_mean=tempsum/(t-rb);
        tempsum2_mean=tempsum2/(t-rb);
        tempsum3_mean=tempsum3/(t-rb);
        tempsum4_mean=tempsum4/(t-rb);
        tita=tempsum_mean^-1*tempsum2_mean;
        xc=tempsum3_mean*tita-tempsum4_mean;
        x=xc'*Q*xc;
        if(x<xmin)
            xmin=x
            titas=tita;
        end
    end
    titata=titata+titas;
end
titata=titata/monteCarlo;
result=tf(titata(2),[1 titata(1)],T0,'variable','z^-1');
display(titata);
display(result);



