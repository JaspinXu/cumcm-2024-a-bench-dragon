screwPitch = 1.7;
head_v = 1;
XY = zeros(448, 201);
VV = zeros(224, 201);

% 获取两个圆的解析值
[x1,y1,x2,y2,rad,r,rmin,alpha0,beta0] = getSolution();
Points = [x1,y1,x2,y2];

for t = -100:100    
    
    
    [head_theta, state] = getThetaByT(t,head_v,screwPitch,rad,r,rmin);
    [x0,y0] = getXY(head_theta, state, screwPitch, Points,r,alpha0);
    % 获取整条队伍的信息
    [X,Y,THETA,STATE] = getBodyLocation(head_theta, state, screwPitch,Points,r,alpha0,rad,rmin);
        
    % 获取速度
    lastTheta = THETA(1);
    lastState = STATE(1);
    lastX = X(1);
    lastY = Y(1);
    lastV = head_v;
    V = zeros(1,224);
    V(1) = lastV;
    
    for i = 2:length(THETA)
        
%         % 画板凳
%         if i == 2
%             len = 2.86;
%         else
%             len = 1.65;
%         end
%         [p1,p2,p3,p4] = blank4Angles([lastX,lastY],[X(i),Y(i)],len);
%         plot([p1(1),p2(1),p3(1),p4(1),p1(1)],[p1(2),p2(2),p3(2),p4(2),p1(2)]);hold on;
        
        theta = THETA(i);
        alpha = getDirectionByTheta(lastTheta,lastState,alpha0,rad);
        beta = getDirectionByTheta(theta,STATE(i),alpha0,rad);
        omega = getBenchDirection(lastX, lastY, X(i), Y(i));
        v = abs(lastV*cos(omega-alpha)/cos(beta-omega));
        V(i) = v;
        lastV = v;
        lastTheta = THETA(i);
        lastState = STATE(i);
        lastX = X(i);
        lastY = Y(i);
        
        
    end
    
        
    % 存入xy坐标数据
    for i = 1:224
        XY(2*i-1,t+101) = X(i);
        XY(2*i,t+101) = Y(i);
    end
    VV(:,t+101) = V';
    
    % 画图
    clf;
    pitch = screwPitch/(2*pi);
    theta0 = (rmin/pitch):0.01*pi:16*pi;
%     theta0 = 0:0.01*pi:16*pi;
    r1 = pitch * theta0;
    % polarplot(theta0,r1,'b');
    [x,y] = pol2cart(theta0,r1);
    plot(x,y);hold on;
    [x,y] = pol2cart(theta0,-r1);
    plot(x,y);hold on;
    % 调头空间
    beta = 0:0.05*pi:2*pi;
    x = cos(beta)*4.5;
    y = sin(beta)*4.5;
    fill(x, y,'yellow','FaceAlpha',0.3);hold on;
    % 转弯圆心
    plot([x1,x2],[y1,y2],'o');hold on;
    % 圆弧
    beta = (alpha0-6*pi):-0.01*pi:beta0;
    x = x1+cos(beta)*2*r;
    y = y1+sin(beta)*2*r;
    plot(x, y,'r','Linewidth', 1);hold on;
    beta = beta0:-0.01*pi:(alpha0-8*pi);
    x = x2+cos(beta)*r;
    y = y2+sin(beta)*r;
    plot(x, y,'r','Linewidth', 1);hold on;
    
%     % 圆相接点
%     plot([1.3662],[-0.2941],'o');hold on
%     % 龙头圆
%     omega = 0:0.01:2*pi;
%     x = X(1) + 2.86*cos(omega);
%     y = Y(1) + 2.86*sin(omega);
%     plot(x,y);
    
    plot(X,Y,'.');hold on;
    plot(X,Y,'b','Linewidth', 1);
    axis equal
    pause(0.01)
    
end


% % 检验
% figure
% plot(1:224,VV(:,175));