% 曼哈顿距离阈值
maxDistance = 5;
maxRadiusDifference = 1;
body_length = 2.2;
head_length = 3.41;
bars = 30;
space_r = 4.5;
minScrewPitch = 0.55;

for screwPitch = 0.45035:-0.00001:0.4503
    % 单次定螺距循环，判断是否达成碰撞条件的标志位
    flag = 0;
    for t = 215:0.1:1000
        theta = getThetaByT(t, screwPitch);
        [x0,y0,r0] = getXYByTheta(theta, screwPitch);
        [R,THETA] = getBodyLocation(theta, screwPitch);

        for bar = 1:bars
            if bar == 1
                l = head_length;
            else
                l = body_length;
            end
            [x0,y0,~] = getXYByTheta(THETA(bar), screwPitch);
            % 获得目标板凳的四点
            [x1,y1,~] = getXYByTheta(THETA(bar+1), screwPitch);
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
                    [x1,y1,~] = getXYByTheta(THETA(i), screwPitch);
                    [x2,y2,~] = getXYByTheta(THETA(i+1), screwPitch);
                    % 距离过远的板凳忽略
                    if abs(p(j,1)-x1)+abs(p(j,2)-y1) > maxDistance || abs(norm([x0,y0])-norm([x1,y1])) > maxRadiusDifference
                        continue
                    end

                    % 判断是否碰撞
                    [a,b,c,d] = blank4Angles([x1,y1],[x2,y2],body_length);  % 板凳四点
                    if pointDetermine([a;b;c;d],p(j,:))
                        flag=1;
                        fprintf('\n螺距：%f发生碰撞。t=%f', screwPitch,t);
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
        fprintf('-');
        if flag
            break
        end
        
        % 判断是否到达调头空间
        if r0 <= space_r
            minScrewPitch = screwPitch;
            fprintf('\n螺距：%f可以到达调头空间。t=%f\n',screwPitch,t);
            break
        end
    end
    
    if flag
        % 发生碰撞，且没有到达调头空间，说明该螺距及之后更小的螺距不满足情况，跳出循环
        
        break
    end
end

screwPitch = 0.44;
% 画出调头空间
theta = 0:0.01:2*pi;
x=4.5*cos(theta);
y=4.5*sin(theta);
fill(x,y,'y');hold on;
% 画出所有板凳
% 碰撞时刻
t_collide = t;
xlim([-10,10])
ylim([-10,10])
for i = 1:223
    if i == 1
        l = head_length;
    else
        l = body_length;
    end
    [x1,y1,~] = getXYByTheta(THETA(i), screwPitch);
    [x2,y2,~] = getXYByTheta(THETA(i+1), screwPitch);
    [a,b,c,d] = blank4Angles([x1,y1],[x2,y2],l);
    plot([a(1) b(1) c(1) d(1) a(1)],[a(2) b(2) c(2) d(2) a(2)]);hold on;
    plot([p(j,1)],[p(j,2)],'.','Color','r','MarkerSize',10);hold on;
end

pitch = screwPitch/(2*pi);
theta0 = (4.5/pitch):0.01*pi:32*pi;
r1 = pitch * theta0;
% polarplot(theta0,r1,'b');
[x,y] = pol2cart(theta0,r1);
plot(x,y);hold on;
axis equal