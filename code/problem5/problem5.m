screwPitch = 1.7;
head_v = 1;
startT=0;
step=0.05;
multi=1000;
XY = zeros(448, multi+1);
VV = zeros(224, multi+1);


% 获取两个圆的解析值
[x1,y1,x2,y2,rad,r,rmin,alpha0,beta0] = getSolution();
Points = [x1,y1,x2,y2];

for head_v=1.221:0.001:1.231
    disp(head_v)
    for i1 = 0:multi
        t=-startT+i1*step;
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
        VV(:,i1+1) = V';

       

    end
    maxV=max(VV);
    mV=max(maxV);
    if mV>2
        plot(-startT:step:-startT+step*multi,maxV);
        break;
    end
    %plot(-startT:step:-startT+step*multi,maxV,'LineWidth',2);
end

