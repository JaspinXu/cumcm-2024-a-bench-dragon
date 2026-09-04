% 通过theta角计算当前速度方向与x轴正方向的夹角
% 参数：
% theta：从0开始，由内到外的角，大于0
% state:状态1是盘内，2、3是圆上，4是盘出
function resAngle = getDirectionByTheta(theta,state,alpha,rad)
    switch state
        case 1
            resAngle = atan(theta) + theta + pi;
        case 2
            resAngle = alpha - theta - pi/2;
        case 3
            resAngle = alpha + theta - pi/2 - rad;
        otherwise
            resAngle = atan(theta) + theta + pi;
    end
end
