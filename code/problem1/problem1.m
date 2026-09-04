pitch = 0.55/(2*pi);
theta0 = 0:0.01*pi:32*pi;
r1 = pitch * theta0;
% 板凳数据
% hole_distance = 27.5;
% head_length = 341;
% head_width = 30;
% head_inner_length = head_length - 2*hole_distance;  % 孔径距离
% body_length = 220;
% body_width = 30;
% body_inner_length = body_length - 2*hole_distance;

XY = zeros(448, 301);
VV = zeros(224, 301);

for t = 0:300
    fprintf('%d',t);
    theta = getThetaByT(t);
    [x,y,r] = getXYByTheta(theta);
    [R,THETA] = getBodyLocation(theta);

    % 获取速度
    lastR = R(1);
    lastTheta = THETA(1);
    lastV = 1;
    V = zeros(1,224);
    V(1) = lastV;
    XY_row = zeros(448,1);
    XY_row(1) = x;
    XY_row(2) = y;
    for i = 2:length(R)
        r = R(i);
        theta = THETA(i);
        alpha = getDirectionByTheta(lastTheta,0);
        beta = getDirectionByTheta(theta,0);
        omega = getBenchDirection(lastR, lastTheta, r, theta);
        v = lastV*cos(omega-alpha)/cos(beta-omega);
        V(i) = v;
        lastV = v;
        lastR = R(i);
        lastTheta = THETA(i);
        
        % 获取x和y
        [x,y,r] = getXYByTheta(theta);
        XY_row(i*2-1) = x;
        XY_row(i*2) = y;
    end
    
    % 表格数据
    XY(:,t+1) = XY_row;
    VV(:,t+1) = V';

end

% 画图
polaraxes;
polarscatter(THETA, R, 20,'filled');hold on;
polarscatter(THETA(1), R(1), 20,'filled', 'r');hold on;
polarplot(theta0,r1,'b');

