% 根据两个把手的坐标（xy），获得四个角上点的坐标（xy）
% 输入：两个把手的平面直角坐标,椅子总长度
% 输出：四个点，resp1 resp2为短边两点，resp2,resp3为长边两点
function [resp1,resp2,resp3,resp4] = blank4Angles(p0,p1,length)
    width = 0.3; % 板凳宽度
    k = (p0(2)-p1(2))/(p0(1)-p1(1));
    centerX = (p0(1)+p1(1))/2;
    centerY = (p0(2)+p1(2))/2;
    % 接下来求长边的中点坐标
    deltaX = length/2*(1/sqrt(1+k^2));
    deltaY = length/2*(k/sqrt(1+k^2));
    pm1 = [centerX+deltaX centerY+deltaY];
    pm2 = [centerX-deltaX centerY-deltaY];
    k2 = -1/k; % 中垂线
    deltaX = width/2*(1/sqrt(1+k2^2));
    deltaY = width/2*(k2/sqrt(1+k2^2));
    resp1 = [pm1(1)-deltaX, pm1(2)-deltaY];
    resp2 = [pm1(1)+deltaX, pm1(2)+deltaY];
    resp3 = [pm2(1)+deltaX, pm2(2)+deltaY];
    resp4 = [pm2(1)-deltaX, pm2(2)-deltaY];
    
    
end