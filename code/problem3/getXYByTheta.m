function [x, y, r] = getXYByTheta(theta, screwPitch)
    
    r = screwPitch/(2*pi)*theta;
    x = r*cos(theta);
    y = r*sin(theta);

end

