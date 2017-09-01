function c_raw = CalC_bp(angle,dev,detection,size_a) % angle: rad; dev: t
% angle: in rad, the angle from y-axis to projection line
% dev = deviation from the middle of picture. Right: positive;
%   left:negative
% size_a any !e!v!e!n! number. size_a*size_a; 
c_raw = zeros(size_a,size_a);
% dev = -dev;
if angle>= pi
    angle = angle-pi;
    dev = -dev;
end
if (angle~=pi/2 && angle~=0)
    theta = angle;
    y = zeros(1,size_a+1);
    for col = 1:size_a+1
        y(col) = size_a/2-dev/sin(theta)+(col-size_a/2-1)/tan(theta);
        % Compare the sinogram of numerical method with the analytical one.
        % If you feel there seem to be some rotation, then modify the first
        % figure: 64.5. If you feel there is merely shift, then modify the
        % dev sent in from the outer codes.
    end
    y_floor = floor(y);
    for col = 1:size_a
        % check the boundary for the top side(start)
        if (y_floor(col)<0)
            if (y_floor(col+1)<0)
                continue;
            end
            if (y_floor(col+1)>=size_a)
                for row = 1:size_a
                    c_raw(row,col) = 1/cos(theta)*detection;
                end
                continue;
            end                        
            for row =0:y_floor(col+1)
                if row == y_floor(col+1)
                    c_raw(row+1,col) = (y(col+1)-row)/cos(theta)*detection;
                else
                    c_raw(row+1,col) = 1/cos(theta)*detection;
                end
            end
            continue;
        end
        % check the boundary for the bottom side(start)
        if (y_floor(col)>=size_a)
            if (y_floor(col+1)>=size_a)
                continue;
            end
            if (y_floor(col+1)<=0)
                for row = 1:size_a
                    c_raw(row,col) = -1/cos(theta)*detection;
                end
                continue;
            end    
            for row =y_floor(col+1):size_a-1
                if row == y_floor(col+1)
                    c_raw(row+1,col) = -(row+1-y(col+1))/cos(theta)*detection;
                else
                    c_raw(row+1,col) = -1/cos(theta)*detection;
                end
            end
            continue;
        end
        % Common Case
        if y_floor(col) == y_floor(col+1)
            c_raw(y_floor(col)+1,col) = sqrt((y(col+1)-y(col))^2+1)*detection;
        else if y_floor(col) < y_floor(col+1)
                for row = y_floor(col):min(y_floor(col+1),size_a-1)
                    if row == y_floor(col)
                        c_raw(row+1,col) = (row+1-y(col))/cos(theta)*detection;
                    else if row == y_floor(col+1)
                            c_raw(row+1,col) = (y(col+1)-row)/cos(theta)*detection;
                        else
                            c_raw(row+1,col) = 1/cos(theta)*detection;
                        end
                    end                    
                end
            else
                % y_floor(col) > y_floor(col+1)
                for row = max(y_floor(col+1),0):y_floor(col)
                    if row == y_floor(col+1)
                        c_raw(row+1,col) = -(row+1-y(col+1))/cos(theta)*detection;
                    else if row == y_floor(col)
                            c_raw(row+1,col) = -(y(col)-row)/cos(theta)*detection;
                        else
                            c_raw(row+1,col) = -1/cos(theta)*detection;
                        end
                    end
                end
            end        
        end
    end
else if angle==0
        % theta =0 degrees
        if dev>size_a/2 || dev<-size_a/2
%            c_raw = sparse(c_raw);
            return;
        end
        if dev==floor(dev)
            for row = 1:size_a
                if dev>-size_a/2 
                    c_raw(row,size_a/2+dev) = 0.5*detection; 
                end
                if dev<size_a/2 
                    c_raw(row,size_a/2+dev+1) = 0.5*detection;
                end
            end
            return;
        end
        for row = 1:size_a
            c_raw(row,ceil(size_a/2+dev)) = 1*detection;
        end
    else
        % theta =90 degrees
        if dev>size_a/2 || dev<-size_a/2
%            c_raw = sparse(c_raw);
            return;
        end
        if dev==floor(dev)
            for col = 1:size_a
                if dev<size_a/2 
                    c_raw(size_a/2-dev,col) = 0.5*detection; 
                end
                if dev>-size_a/2 
                    c_raw(size_a/2-dev+1,col) = 0.5*detection;
                end
            end
            return;
        end
        for col = 1:size_a
            c_raw(ceil(size_a/2-dev),col) = 1*detection;
        end
    end
end
%c_raw = sparse(c_raw);