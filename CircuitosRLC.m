%Declaração dos valores dos componentes
R = 39000;                                 %R = 39K Ohms
L = 0.0091;                                %L = 9,1 mH
C = 0.0000056;                             %C = 5,6 uF

R1 = 110;                                  %R1 = 110 Ohms                
L1 = 0.001;                                %L1 = 1 mH    
C1 = 0.0000000033;                         %C2 = 3,3 nF 

R2 = 110;                                  %R3 = 110 Ohms
L2 = 0.001;                                %L3 = 1 mH
C2 = 0.00000033;                           %C3 = 0,33 uF

R3 = 110;                                  %R4 = 110 Ohms      
L3 = 0.001;                                %L4 = 1 mH  
C3 = 0.0033;                               %C4 = 3,3 mF

%Função de trasferência Circuito RC-Série(Low-Pass) -> H(S) = 1 / (RCS + 1) 
RC_1num = [1];                            %Numerador
RC_1den = [R1*C1 1];                      %Denominador
RC_1 = tf(RC_1num,RC_1den);               %Função de trasferência
I_RC_1 = impulse(RC_1);                   %Resposta ao impulso unitário
S_RC_1 = step(RC_1);                      %Respota ao degrau unitário
B_RC_1 = bode(RC_1);                      %Diagrama de bode
tRC = 0:0.00000001:0.00001;               %Definindo um intervalo de tempo                 
sinRC = lsim(RC_1,sin(1000000*tRC),tRC);  %Resposta ao seno de 1000000 rad/s       

%Função de trasferência 2 Circuito RC-Série(Low-Pass) -> H(S) = 1 / (RCS + 1) 
RC_2num = [1];                            %Numerador
RC_2den = [R*C 1];                        %Denominador
RC_2 = tf(RC_2num,RC_2den);               %Função de trasferência  
I_RC_2 = impulse(RC_2);                   %Resposta ao impulso unitário
S_RC_2 = step(RC_2);                      %Resposta ao degrau unitaário  
B_RC_2 = bode(RC_2);                      %Diagrama de bode

%Função de trasferência Circuito RL-Série(High-Pass) -> H(S) = LS / (LS + R)
RL_1num = [L1 0];                         %Numerador  
RL_1den = [L1 R1];                        %Denominador  
RL_1 = tf(RL_1num,RL_1den);               %Função de trasferência
I_RL_1 = impulse(RL_1);                   %Resposta ao impulso unitário
S_RL_1 = step(RL_1);                      %Respota ao degrau unitário
B_RL_1 = bode(RL_1);                      %Diagrama de bode
tRL = 0:0.0000001:0.0001;                 %Definindo um intervalo de tempo                 
sinRL = lsim(RL_1,sin(100000*tRL),tRL);   %Resposta ao seno de 100000 rad/s 

%Função de trasferência 2 Circuito RL-Série(High-Pass) -> H(S) = LS / (LS + R)
RL_2num = [L 0];                         %Numerador  
RL_2den = [L R];                         %Denominador  
RL_2 = tf(RL_1num,RL_1den);              %Função de trasferência
I_RL_2 = impulse(RL_2);                  %Resposta ao impulso unitário   
S_RL_2 = step(RL_2);                     %Respota ao degrau unitário
B_RL_2 = bode(RL_2);                     %Diagrama de bode

%Função de trasferência 1 Circuito RLC-Serie 1(Band-Pass) -> H(S) = ((R / L)S) / (S^2 + (R / L)S + (1 / LC))  
%Subamortecido C < (4L) / (R^2)
RLC1_1num = [(R1/L1) 0];                %Numerador
RLC1_1den = [1 (R1/L1) 1/(L1*C1)];      %Denominador
RLC1_1 = tf(RLC1_1num,RLC1_1den);       %Função de trasferência
I_RLC1_1 = impulse(RLC1_1);             %Resposta ao impulso unitário 
S_RLC1_1 = step(RLC1_1);                %Respota ao degrau unitário
B_RLC1_1 = bode(RLC1_1);                %Diagrama de bode
tRLC1 = 0:0.00000001:0.00008;           %Definindo um intervalo de tempo 
sinRLC1 = lsim(RLC1_1,sin(600000*tRLC1),tRLC1);   %Resposta ao seno de 600000 rad/s

%Função de trasferência 2 Circuito RLC-Serie 1(Band-Pass) -> H(S) = ((R / L)S) / (S^2 + (R / L)S + (1 / LC))  
%Amortecimento crítico C = (4L) / (R^2)
RLC1_2num = [(R2/L2) 0];                %Numerador
RLC1_2den = [1 (R2/L2) 1/(L2*C2)];      %Denominador
RLC1_2 = tf(RLC1_2num,RLC1_2den);       %Função de trasferência
I_RLC1_2 = impulse(RLC1_2);             %Resposta ao impulso unitário
S_RLC1_2 = step(RLC1_2);                %Respota ao degrau unitário
B_RLC1_2 = bode(RLC1_2);                %Diagrama de bode  

%Função de trasferência 3 Circuito RLC-Serie 1(Band-Pass) -> H(S) = ((R / L)S) / (S^2 + (R / L)S + (1 / LC))
%Superamortecido C > (4L) / (R^2)
RLC1_3num = [(R3/L3) 0];                %Numerador
RLC1_3den = [1 (R3/L3) 1/(L3*C3)];      %Denominador
RLC1_3 = tf(RLC1_3num,RLC1_3den);       %Função de trasferência
I_RLC1_3 = impulse(RLC1_3);             %Resposta ao impulso unitário
S_RLC1_3 = step(RLC1_3);                %Respota ao degrau unitário
B_RLC1_3 = bode(RLC1_3);                %Diagrama de bode

%Função de trasferência 1 Circuito RLC-Serie 2(Band-Stop) -> H(S) = (S^2 + (1 / LC)) / (S^2 + (R / L)S + (1 / LC)
%Subamortecido C < (4L) / (R^2)
RLC2_1num = [1 0 (1/(L1*C1))];          %Numerador
RLC2_1den = [1 (R1/L1) 1/(L1*C1)];      %Denominador
RLC2_1 = tf(RLC2_1num,RLC2_1den);       %Função de trasferência
I_RLC2_1 = impulse(RLC2_1);             %Resposta ao impulso unitário
S_RLC2_1 = step(RLC2_1);                %Respota ao degrau unitário
B_RLC2_1 = bode(RLC2_1);                %Diagrama de bode
tRLC2 = 0:0.00000001:0.00008;           %Definindo um intervalo de tempo 
sinRLC2 = lsim(RLC2_1,sin(600000*tRLC2),tRLC2);   %Resposta ao seno de 600000 rad/s

%Função de trasferência 2 CircuitoRLC-Serie 2(Band-Stop) -> H(S) = (S^2 + (1 / LC)) / (S^2 + (R / L)S + (1 / LC)
%Amortecimento crítico C = (4L) / (R^2)
RLC2_2num = [1 0 (1/(L2*C2))];          %Numerador
RLC2_2den = [1 (R2/L2) 1/(L2*C2)];      %Denominador
RLC2_2 = tf(RLC2_2num,RLC2_2den);       %Função de trasferência
I_RLC2_2 = impulse(RLC2_2);             %Resposta ao impulso unitário
S_RLC2_2 = step(RLC2_2);                %Respota ao degrau unitário
B_RLC2_2 = bode(RLC2_2);                %Diagrama de bode  

%Função de trasferência 3 Circuito RLC-Serie 2(Band-Stop) -> H(S) = (S^2 + (1 / LC)) / (S^2 + (R / L)S + (1 / LC) 
%Superamortecido C > (4L) / (R^2)
RLC2_3num = [1 0 (1/(L3*C3))];          %Numerador
RLC2_3den = [1 (R3/L3) 1/(L3*C3)];      %Denominador
RLC2_3 = tf(RLC2_3num,RLC2_3den);       %Função de trasferência
I_RLC2_3 = impulse(RLC2_3);             %Resposta ao impulso unitário
S_RLC2_3 = step(RLC2_3);                %Respota ao degrau unitário
B_RLC2_3 = bode(RLC2_3);                %Diagrama de bode

%Função de trasferência 1 Circuito RLC-Serie 3(Low-Pass) -> H(S) = ((1 / LC)) / (S^2 + (R / L)S + (1 / LC)   
%Subamortecido C < (4L) / (R^2)
RLC3_1num = [(1/(L1*C1))];              %Numerador  
RLC3_1den = [1 (R1/L1) 1/(L1*C1)];      %Denominador  
RLC3_1 = tf(RLC3_1num,RLC3_1den);       %Função de trasferência
I_RLC3_1 = impulse(RLC3_1);             %Resposta ao impulso unitário
S_RLC3_1 = step(RLC3_1);                %Respota ao degrau unitário
B_RLC3_1 = bode(RLC3_1);                %Diagrama de bode
tRLC3 = 0:0.00000001:0.00008;           %Definindo um intervalo de tempo 
sinRLC3 = lsim(RLC3_1,sin(1000000*tRLC3),tRLC3);   %Resposta ao seno de 1000000 rad/s

%Função de trasferência 2 Circuito RLC-Serie 3(Low-Pass) -> H(S) = ((1 / LC)) / (S^2 + (R / L)S + (1 / LC) 
%Amortecimento crítico C = (4L) / (R^2)
RLC3_2num = [(1/(L2*C2))];              %Numerador  
RLC3_2den = [1 (R2/L2) 1/(L2*C2)];      %Denominador  
RLC3_2 = tf(RLC3_2num,RLC3_2den);       %Função de trasferência
I_RLC3_2 = impulse(RLC3_2);             %Resposta ao impulso unitário
S_RLC3_2 = step(RLC3_2);                %Respota ao degrau unitário
B_RLC3_2 = bode(RLC3_2);                %Diagrama de bode  

%Função de trasferência 3 Circuito RLC-Serie 3(Low-Pass) -> H(S) = ((1 / LC)) / (S^2 + (R / L)S + (1 / LC)  
%Superamortecido C > (4L) / (R^2)
RLC3_3num = [(1/(L3*C3))];              %Numerador
RLC3_3den = [1 (R3/L3) 1/(L3*C3)];      %Denominador  
RLC3_3 = tf(RLC3_3num,RLC3_3den);       %Função de trasferência
I_RLC3_3 = impulse(RLC3_3);             %Resposta ao impulso unitário
S_RLC3_3 = step(RLC3_3);                %Respota ao degrau unitário
B_RLC3_3 = bode(RLC3_3);                %Diagrama de bode

%Correlação entre as respostas ao degrau initário dos circuitos RC série e RL série
co1 = corr(S_RC_1,S_RC_1);              %Correlação entre as respostas do degrau unitário de dois circuitos RC série inguais
co2 = corr(S_RC_1,S_RC_2);              %Correlação entre as respostas do degrau unitário de dois circuitos RC série diferentes
co3 = corr(S_RL_1,S_RL_1);              %Correlação entre as respostas do degrau unitário de dois circuitos RL série inguais
co4 = corr(S_RL_1,S_RL_2);              %Correlação entre as respostas do degrau unitário de dois circuitos RL série diferentes
co5 = corr(S_RC_1,S_RL_1);              %Correlação entre as respostas do degrau unitário de um circuito RC série e um circuito RL série
co6 = corr(S_RC_2,S_RL_2);              %Correlação entre as respostas do degrau unitário de um circuito RC série e um circuito RL série
co7 = corr(S_RC_1,S_RL_2);              %Correlação entre as respostas do degrau unitário de um circuito RC série e um circuito RL série
co8 = corr(S_RC_2,S_RL_1);              %Correlação entre as respostas do degrau unitário de um circuito RC série e um circuito RL série

%obtendo o valor da constante de tempo do circuito RC série
%O produto R x C é o tempo necessario para que o capacitor atinja 63,2% de sua tensão máxima.
[yC,xC] = step(RC_1);                     %Guardando o valor da ordenadas em yC e da abscissa em xC do gráfico da resposta ao degrau unitario do circuito RC série 
ymaxC = max(yC);                          %Guardando o valor máximo de yC em ymaxC                           
yC62 = ymaxC*0.62;                        %Guardando o valor 62% de ymaxC em yC62
yC64 = ymaxC*0.64;                        %Guardando o valor 64% de ymaxC em yC64
xC63 = xC(yC>yC62 & yC<yC64);             %Guardando os valores de xC em xC63 correspondentes no gráfico aos valores entre yC62 e yC64  
tC = median(xC63);                        %Guardando em tC a média dos valores da variável xC63. tC = R x C é a constante de tempo 

%obtendo o valor da constante de tempo do circuito RL série
%O quociente L / R é o tempo necessario para que a tensão no circuito chegue a 36,8% da sua tensão máxima.
[yL,xL] = step(RL_1);                     %Guardando o valor da ordenadas em yL e da abscissa em xL do gráfico da resposta ao degrau unitario do circuito RC série 
ymaxL = max(yL);                          %Guardando o valor máximo de yL em ymaxL                           
yL36 = ymaxL*0.36;                        %Guardando o valor 36% de ymax em yL36
yL38 = ymaxL*0.38;                        %Guardando o valor 38% de ymax em yL38
xL37 = xL(yL>yL36 & yL<yL38);             %Guardando os valores de xL em xL37 correspondentes no gráfico aos valores entre yL36 e yL38  
tL = median(xL37);                        %Guardando em tL a média dos valores da variável xL37. tL = L / R é a constante de tempo 
