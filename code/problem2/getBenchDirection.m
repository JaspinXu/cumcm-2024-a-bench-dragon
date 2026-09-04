% 输入两个点的极坐标，输出两个点向量与x轴正方向的夹角，即板凳方向
function theta = getBenchDirection(r0, theta0, r1, theta1)

    dx = r0*cos(theta0) - r1*cos(theta1);
    dy = r0*sin(theta0) - r1*sin(theta1);
    theta = atan2(dy, dx);
    if theta < 0
       theta = theta + 2*pi; 
    end

end

