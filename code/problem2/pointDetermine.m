% 判断点是否在矩形内
% 1为是，0为否
function result = pointDetermine(points, p)

    result = 1;
    % 宽判断
    p1 = points(1,:);
    p2 = points(2,:);
    if dot(p1-p,p1-p2)<0 || dot(p2-p,p2-p1)<0
        result = 0;
    end
    % 长判断
    p1 = points(2,:);
    p2 = points(3,:);
    if dot(p1-p,p1-p2)<0 || dot(p2-p,p2-p1)<0
        result = 0;
    end

end

