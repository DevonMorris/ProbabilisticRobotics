function l = inverse_range_sensor(mi, xt, zt, thk)
    l0 = log(.5/.5);
    locc = log(.7/.3);
    lfree = log(.3/.7);

    % === Set up params for inverse measurement model =========================
    alpha = 1.2; % average thickness of obstacles in meters
    beta = 2*pi/180; % width of the sensor beam
    z_max = 150; % max distance of sensor

    xi = mi(1);
    yi = mi(2);
    
    xb = xt(1);
    yb = xt(2);
    thb = xt(3);

    r = sqrt((xi - xb)^2 + (yi - yb)^2);
    phi = atan2(yi-yb, xi-xb) - thb;
    if phi > pi
        phi = phi - 2*pi;
    elseif phi < -pi
        phi = phi + 2*pi;
    end
    [m,k] = min(abs(phi - thk));
    
    ztk = zt(1,k);
    
    if r > (ztk + alpha/2) || m > beta/2
        l = l0;
    elseif abs(r - ztk) < alpha/2
        l = locc;
    else
        l = lfree;
end