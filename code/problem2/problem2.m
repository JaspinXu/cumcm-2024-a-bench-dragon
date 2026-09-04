% 曼哈顿距离阈值
maxDistance = 5;
maxRadiusDifference = 1;
body_length = 2.2;
head_length = 3.41;
bars = 30;

% 判断是否达成碰撞条件的标志位，碰撞时间点约为412.474054
flag = 0;
for t = 412.474:0.000001:412.4742
% for t = 413.5:0.01:413.6
    theta = getThetaByT(t);
    [x0,y0,~] = getXYByTheta(theta);
    [R,THETA] = getBodyLocation(theta);
    
    for bar = 1:bars
        if bar == 1
            l = head_length;
        else
            l = body_length;
        end
        [x0,y0,~] = getXYByTheta(THETA(bar));
        % 获得目标板凳的四点
        [x1,y1,~] = getXYByTheta(THETA(bar+1));
        [a0,b0,c0,d0] = blank4Angles([x0,y0],[x1,y1],l);
        P = [a0;b0;c0;d0];
        % 取出目标板凳最有可能碰撞的两个点（即靠外的点）
        [~,indexs] = sort([norm(a0),norm(b0),norm(c0),norm(d0)]);
        p1 = P(indexs(end),:);
        p2 = P(indexs(end-1),:);

        p = [p1;p2];
        % 将两点分别进行碰撞检测
        for j = 1:2
            for i = bar+2:length(R)-1
                % 板凳的两个孔径坐标
                [x1,y1,~] = getXYByTheta(THETA(i));
                [x2,y2,~] = getXYByTheta(THETA(i+1));
                % 距离过远的板凳忽略
                if abs(p(j,1)-x1)+abs(p(j,2)-y1) > maxDistance || abs(norm([x0,y0])-norm([x1,y1])) > maxRadiusDifference
                    continue
                end

                % 判断是否碰撞
                [a,b,c,d] = blank4Angles([x1,y1],[x2,y2],body_length);  % 板凳四点
                if pointDetermine([a;b;c;d],p(j,:))
%                     figure
%                     plot([a(1) b(1) c(1) d(1) a(1)],[a(2) b(2) c(2) d(2) a(2)]);hold on;
%                     plot([p(j,1)],[p(j,2)],'.')
%                     xlim([-10,10])
%                     ylim([-10,10]) 
                    flag=1;
                    fprintf('发生碰撞');
                    break
                end  
            end
            if flag
                break
            end
        end
        
        if flag
            break
        end
    end
    fprintf('%d\r',t);
    if flag
        break
    end
end

% 画出所有板凳
% 碰撞时刻
t_collide = t;
figure
xlim([-10,10])
ylim([-10,10])
for i = 1:223
    if i == 1
        l = head_length;
    else
        l = body_length;
    end
    [x1,y1,~] = getXYByTheta(THETA(i));
    [x2,y2,~] = getXYByTheta(THETA(i+1));
    [a,b,c,d] = blank4Angles([x1,y1],[x2,y2],l);
    plot([a(1) b(1) c(1) d(1) a(1)],[a(2) b(2) c(2) d(2) a(2)]);hold on;
    plot([p(j,1)],[p(j,2)],'.','Color','r','MarkerSize',10);hold on;
end

% 表格数据
X = zeros(224,1);
Y = zeros(224,1);
V = zeros(224,1);
theta = getThetaByT(t_collide);
[x0,y0,~] = getXYByTheta(theta);
[R,THETA] = getBodyLocation(theta);
lastR = R(1);
lastTheta = THETA(1);
lastV = 1;
% 初始值
X(1) = x0;
Y(1) = y0;
V(1) = 1;
for i = 2:224
    [x,y,~] = getXYByTheta(THETA(i));
    X(i) = x;
    Y(i) = y;
    % 获取速度
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
end

pitch = 0.55/(2*pi);
theta0 = 0:0.01*pi:32*pi;
r1 = pitch * theta0;
result = [X,Y,V];
% polarplot(theta0,r1,'b');
[x,y] = pol2cart(theta0,r1);
plot(x,y);
axis equal