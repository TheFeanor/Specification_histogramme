function y = proj(x)

if x > 1
    y = 1-1e-6;
else
    if x < 0
        y = 1e-6;
    else
        y = x;
    end
end
        

end

