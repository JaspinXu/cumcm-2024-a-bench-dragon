% 输入龙头相角，输出整条龙包括龙头、龙身、龙尾的位置（极坐标）
function [R, THETA] = getBodyLocation(head_theta, screwPitch)

    dr0 = 3;
    sum = 223;
    k = screwPitch/(2*pi);
    r0 = head_theta * k;
    % 板凳孔径距离
    head_inner_length = 2.86;
    body_inner_length = 1.65;
    R = zeros(1,sum+1);
    THETA = zeros(1,sum+1);
    
    f = @(x) (x^2+r0^2-head_inner_length^2)-2*x*r0*cos((x-r0)/k);
    
    % 龙头
    R(1) = r0;
    THETA(1) = R(1)/k;
    % 第一个龙身前把手
    try
        R(2) = fzero(f,[r0,r0+dr0]);
    catch
        1
    end
    THETA(2) = R(2)/k;
    
    % 其余把手
    for i = 3:sum+1
        r0 = R(i-1);
        f = @(x) (x^2+r0^2-body_inner_length^2)-2*x*r0*cos((x-r0)/k);
        R(i) = fzero(f,[R(i-1),R(i-1)+dr0]);
        THETA(i) = R(i)/k;
    end

end

