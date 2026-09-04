% 输入两个点的坐标，输出两个点向量与x轴正方向的夹角，即板凳方向
function theta = getBenchDirection(x0, y0, x1, y1)

    dx = x0 - x1;
    dy = y0 - y1;
    theta = atan2(dy, dx);
    if theta < 0
       theta = theta + 2*pi; 
    end

end

