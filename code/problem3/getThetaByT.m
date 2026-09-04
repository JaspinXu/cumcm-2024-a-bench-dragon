function result = getThetaByT(tfinal, screwPitch)
    b = 32 * pi;
    start_t = (b*sqrt(b^2+1)+log(b+sqrt(b^2)+1))*screwPitch/(4*pi);
    % 从进入螺线开始计时
    % 提高解的精度
    options = odeset('RelTol',1e-10,'AbsTol',1e-10);
    % 求偏微分方程的离散解
    [t, Xt] = ode45(@SunFun, [0 start_t-tfinal], 0, options);   
    
    result = Xt(end);

    % 微分方程函数，状态导数
    function xdot = SunFun(t, x)
        xdot = 2*pi/screwPitch*1/sqrt(x^2+1);
    end
end