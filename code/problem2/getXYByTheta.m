function [x, y, r] = getXYByTheta(theta)
    
    r = 0.55/(2*pi)*theta;
    x = r*cos(theta);
    y = r*sin(theta);

end

