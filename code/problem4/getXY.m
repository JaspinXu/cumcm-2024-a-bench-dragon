% 输入角度和状态，螺距
function [x, y] = getXY(theta, state, screwPitch,Points,r,alpha)
    k = screwPitch/(2*pi);
    % 圆的圆心
    circle = [Points(1),Points(2);Points(3),Points(4)];
    switch state
        case 1
            r = k*theta;
            x = r*cos(theta);
            y = r*sin(theta);
        case 2
            x = circle(1,1) + 2*r*cos(alpha-theta);
            y = circle(1,2) + 2*r*sin(alpha-theta);
        case 3
            x = circle(2,1) + r*cos(alpha+theta);
            y = circle(2,2) + r*sin(alpha+theta);
        otherwise
            r = -k*theta;
            x = r*cos(theta);
            y = r*sin(theta);
    end
    
end

