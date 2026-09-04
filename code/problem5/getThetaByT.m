% 输入时间,龙头速度和螺距
% 时间零点为进入调头空间的时刻
function [result,state] = getThetaByT(tfinal,v,screwPitch,rad,r,rmin)
    % 弧长
    arc_length = [rad*r*2,rad*r];
    spendT = arc_length/v;
    k = screwPitch/(2*pi);
    b = rmin/k;
    start_t = (b*sqrt(b^2+1)+log(b+sqrt(b^2)+1))*k/2/v;
    % 提高解的精度
    options = odeset('RelTol',1e-10,'AbsTol',1e-10);
    % 求偏微分方程的离散解
    if tfinal<0
        [t, Xt] = ode45(@SunFun, [0 start_t-tfinal], 0, options);  
        state = 1;
    elseif tfinal<spendT(1)     % 第一个圆弧上
        result = v*tfinal/(2*r);
        state = 2;
        return
    elseif tfinal<sum(spendT)     % 第二个圆弧上
        result = v*(tfinal-spendT(1))/r;
        state = 3;
        return
    else    % 盘出螺线
        [t, Xt] = ode45(@SunFun, [0 tfinal-sum(spendT)+start_t], 0, options);  
        state = 4;
    end
    result = Xt(end);        

    % 微分方程函数，状态导数
    function xdot = SunFun(t, x)
        xdot = v/sqrt(x^2+1)/k;
    end

end

