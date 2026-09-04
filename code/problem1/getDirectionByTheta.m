% 通过theta角计算当前速度方向与x轴正方向的夹角
% 参数：
% theta：从0开始，由内到外的角，大于0
% inOrOut：盘内还是盘外 0盘内，1盘外
function resAngle = getDirectionByTheta(theta,inOrOut)
    if inOrOut
        resAngle = atan(theta) + theta;
    else
        resAngle = atan(theta) + theta + pi;
end