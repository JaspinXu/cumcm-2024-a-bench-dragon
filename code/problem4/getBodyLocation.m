function [X, Y, THETA, STATE] = getBodyLocation(head_theta, state, screwPitch,Points,r,alpha,rad,rmin)

    sum = 224;
    l1 = 2.86;
    l2 = 1.65;
    X = zeros(1,sum);
    Y = zeros(1,sum);
    THETA = zeros(1,sum);
    STATE = zeros(1,sum);
    [x0,y0] = getXY(head_theta, state, screwPitch,Points,r,alpha);
    X(1) = x0;
    Y(1) = y0;
    THETA(1) = head_theta;
    STATE(1) = state;
    lastTheta = head_theta;
    lastArea = state;
    for i = 2:sum
        if i == 2
            l = l1;
        else
            l = l2;
        end
        [resTheta, resArea, x0, y0] = iterHandles4(lastTheta, lastArea, l, r, rad, Points,alpha,rmin);
%         disp(lastTheta)
        if x0 == 0
            [x,y] = getXY(resTheta, resArea, screwPitch,Points,r,alpha);
            X(i) = x;
            Y(i) = y;
        else
            X(i) = x0;
            Y(i) = y0;
        end
        THETA(i) = resTheta;
        STATE(i) = resArea;
        lastTheta = resTheta;
        lastArea = resArea;
    end

end

