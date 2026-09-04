function [x1,y1,x2,y2,rad,r,rmin,alpha,beta] = getSolution()
    k = 1.7/2/pi;
    % 调头半径
    rmin = 4.5;
    
    % 盘入点的方向和坐标
    thetaIn = getDirectionByTheta(rmin/k,1);
    xIn = rmin*cos(rmin/k);
    yIn = rmin*sin(rmin/k);
    % 矩形长宽
    W = 2*rmin*cos(atan(thetaIn));
    L = 2*rmin*sin(atan(thetaIn));
    % 小圆半径和弧度角
    r = (W^2+L^2)/6/L;
    rad = pi-atan(W/(L-3*r));
    % 大圆坐标
    x1 = xIn + 2*r*cos(thetaIn-pi/2);
    y1 = yIn + 2*r*sin(thetaIn-pi/2);
    % 小圆坐标
    x2 = -xIn - r*cos(thetaIn-pi/2);
    y2 = -yIn - r*sin(thetaIn-pi/2);
    % 圆心交线与x轴正方向的夹角
    beta = atan2(y2-y1,x2-x1);
    % 盘入螺线点的法向量与x轴正向夹角.
    alpha = thetaIn+pi/2;
end