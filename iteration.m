clc;
clear;
p = 90;
T0 = 293.15;
shidu = 0.15;
a = 2500000/1005;
b = 0.622*2.53*10^8*1/p;
w = shidu*0.622*2.53*10^8*exp(-5420/T0)/p;
n = 5;         %希望的一次迭代次数
TTw=1:n;
TTw(1) = T0-a*(b*exp(-5420/T0)-w);
TTw(2) = T0-a*(b*exp(-5420/TTw(1))-w);
i = 2;
j = 0;
maxdis = 1:n-1;
while abs(TTw(i)-TTw(i-1)) >= 10^(-6)
    TTw(i+1) = T0-a*(b*exp(-5420/TTw(i))-w);
    i = i+1;
    if i == n
        j = j+1;
        for i =1:n-1
            maxdis(i)=abs(TTw(i+1)-TTw(i));
        end
        [m,index] = min(maxdis);
        new = abs(TTw(index)+TTw(index+1))/2;
        TTw(1) = T0-a*(b*exp(-5420/new)-w);
        TTw(2) = T0-a*(b*exp(-5420/TTw(1))-w);
        i = 2;
    end
end
%在打开TTw数组验证结果是，TTw（i）为最终迭代结果，之后的dw是上一次初值循环留下的不收敛的值，没意义
T2 = TTw(i);
dw = -1005/2.5/10^6*(TTw(i)-T0);
% Tv = TTw(i)*((1+(w+dw)/0.622)/(1+w+dw));
Tv = TTw(i)*(1+(w+dw)*0.6);
rou = 100000/287/Tv;
%需要的水分
shuifen = rou*100*dw;
%验证空气中相对湿度
f2 = (w+dw)/(b*exp(-5420/T2)/0.65);



p0 = 80;
a = 0.622*2.53*10^8*exp(-5420/Tc(11))/((Tc(11)/268)^(1/0.286)*p0*Tc(11));
b = 2.5*10^6/1005;
Te = 273;
weie = Te*(5/4)^(0.286);
i = 2;
weiw =1:200;    %假设迭代两百次之内有结果
wei = 285;
weiw(1) = wei*exp(b*(a-0.622*2.53*10^8*exp(-5420/wei)/(100*wei)));
weiw(2)= wei*exp(b*(a-0.622*2.53*10^8*exp(-5420/weiw(i))/(100*weiw(1))));
while abs(weiw(i)-weiw(i-1)) >= 10^(-6)
    weiw(i+1) =wei*exp(b*(a-0.622*2.53*10^8*exp(-5420/weiw(i))/(100*weiw(i))));
    i = i+1;
    if i >=200
        break;
    end
end
