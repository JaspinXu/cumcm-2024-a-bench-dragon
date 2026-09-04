maxL = 2.86;
% 求刚好不卡死下的外接圆半径
fun = @(x) getChordLength(x)-maxL;
rmin = fzero(fun,[4.0,4.5])

% 求弦长
function result = getChordLength(rmin)
    k = 1.7/2/pi;
    thetaIn = getDirectionByTheta(rmin/k,1);
    % 矩形长宽
    W = 2*rmin*cos(atan(thetaIn));
    L = 2*rmin*sin(atan(thetaIn));
    % 小圆半径和弧度角
    r = (W^2+L^2)/6/L;
    rad = pi-atan(W/(L-3*r));
    result = r*sin(rad/2)*2;
end