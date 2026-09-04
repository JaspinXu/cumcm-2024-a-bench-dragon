function [resTheta,nextArea,resultX,resultY] = iterHandles4(theta,area,l,r,rad,Points,alpha,rmin)
    resultX = 0;
    resultY = 0;
    k=1.7/2/pi;
    Rmin=4.228886952526264;
    
    % 圆的交点
    XX = Points(1) + (Points(3)-Points(1))*2/3;
    YY = Points(2) + (Points(4)-Points(2))*2/3;
    
    
    
    if area == 1 % 当前在一区
        r0=k*theta;
%         disp(theta)
        dr0=2;
        f = @(x) (x^2+r0^2-l^2)-2*x*r0*cos((x-r0)/k);
        resR = fzero(f,[r0,r0+dr0]);
        resTheta = resR/k;
        nextArea=1;
    elseif area == 2
        if theta<2*asin(l/r/4)
            [x0,y0] = getXY(theta,2,1.7,Points,r,alpha);
%             r0 = sqrt(x0^2+y0^2);
            dr0 = 3;
            f = @(x) (k*x*cos(x)-x0)^2 + (k*x*sin(x)-y0)^2 - l^2;
            resTheta = fzero(f,[rmin/k,rmin/k+dr0]);
            nextArea=1;
        else
            resTheta = theta - 2*asin(l/r/4);
            nextArea=2;
        end
    elseif area == 3
        if theta<2*asin(l/r/2)
            % 板凳在两圆弧之间            
            [x0,y0] = getXY(theta, 3, 17,Points,r,alpha);
            
            % 已知参数
            c1 = [x0, y0];    % 第一个圆心坐标
            r1 = l;         % 第一个圆的半径
            c2 = [Points(1), Points(2)];    % 第二个圆心坐标
            r2 = 2*r;       % 第二个圆的半径

            % 计算两个圆的交点
            d = norm(c2 - c1);  % 两个圆心的距离
            a = (r1^2 - r2^2 + d^2)/(2*d);
            h = sqrt(r1^2 - a^2);
            p = c1 + a*(c2 - c1)/d;
            x1 = p(1) + h*(c2(2) - c1(2))/d;
            y1 = p(2) - h*(c2(1) - c1(1))/d;
            x2 = p(1) - h*(c2(2) - c1(2))/d;
            y2 = p(2) + h*(c2(1) - c1(1))/d;

            % 选择正确的解（即在圆弧上的解）
            if y1 < y2
                realX = x2;
                realY = y2;
            else
                realX = x1;
                realY = y1;
            end            
            
            d = sqrt((realX-Points(3))^2+(realY-Points(4))^2);
            resTheta = rad - acos(((2*r)^2+(3*r)^2-d^2)/(2*2*r*3*r));
            resultX = realX;
            resultY = realY;
            
            nextArea=2;
        else
            resTheta = theta - 2*asin(l/r/2);
            nextArea=3;
        end
    elseif area == 4
        % 边界条件
        r0 = rmin;
        dr0 = 2;
        f = @(x) (x^2+r0^2-l^2)-2*x*r0*cos((x-r0)/k);
        Rmin2 = fzero(f,[r0,r0+2]);
    
        if l > sin(rad/2)*r*2 && theta*k < Rmin
            % 一个点在螺线，另一个点在大圆
            % 圆心
            xr=Points(1);
            yr=Points(2);
            [x0,y0] = getXY(theta,4,1.7,Points,r,alpha);
            
            % 已知参数
            c1 = [x0, y0];    % 第一个圆心坐标
            r1 = l;         % 第一个圆的半径
            c2 = [xr, yr];    % 第二个圆心坐标
            r2 = 2*r;       % 第二个圆的半径

            % 计算两个圆的交点
            d = norm(c2 - c1);  % 两个圆心的距离
            a = (r1^2 - r2^2 + d^2)/(2*d);
            h = sqrt(r1^2 - a^2);
            p = c1 + a*(c2 - c1)/d;
            x1 = p(1) + h*(c2(2) - c1(2))/d;
            y1 = p(2) - h*(c2(1) - c1(1))/d;
            x2 = p(1) - h*(c2(2) - c1(2))/d;
            y2 = p(2) + h*(c2(1) - c1(1))/d;

            % 选择正确的解（即在圆弧上的解）
            if y1 < y2
                realX = x2;
                realY = y2;
            else
                realX = x1;
                realY = y1;
            end
            d = sqrt((realX-Points(3))^2+(realY-Points(4))^2);
            resTheta = rad - acos(((2*r)^2+(3*r)^2-d^2)/(2*2*r*3*r));
            resultX = realX;
            resultY = realY;
            
            nextArea=2;
        elseif theta*k<Rmin2
            % 一个在圆弧，另一个在螺线
            % 圆心
            xr=Points(3);
            yr=Points(4);
            [x0,y0] = getXY(theta,4,1.7,Points,r,alpha);
            
            % 已知参数
            c1 = [x0, y0];    % 第一个圆心坐标
            r1 = l;         % 第一个圆的半径
            c2 = [xr, yr];    % 第二个圆心坐标
            r2 = r;       % 第二个圆的半径

            % 计算两个圆的交点
            d = norm(c2 - c1);  % 两个圆心的距离
            a = (r1^2 - r2^2 + d^2)/(2*d);
            h = sqrt(r1^2 - a^2);
            p = c1 + a*(c2 - c1)/d;
            x1 = p(1) + h*(c2(2) - c1(2))/d;
            y1 = p(2) - h*(c2(1) - c1(1))/d;
            x2 = p(1) - h*(c2(2) - c1(2))/d;
            y2 = p(2) + h*(c2(1) - c1(1))/d;

            % 选择正确的解（即在圆弧上的解）
            if x1 < x2
                realX = x2;
                realY = y2;
            else
                realX = x1;
                realY = y1;
            end
            
            d = sqrt((realX-XX)^2+(realY-YY)^2);
            resTheta = 2*asin(d/2/r);
            resultX = realX;
            resultY = realY;
            
            nextArea=3;
        else
            % 都在螺线上
            r0=k*theta;
            dr0=2;
            f = @(x) (x^2+r0^2-l^2)-2*x*r0*cos((x-r0)/k);
            resR = fzero(f,[r0-dr0,r0]);
            resTheta = resR/k;
            nextArea=4;
        end
    end
    
end