function H = choose_hs(im)
    h = hist(im);
    H = zeros(256, 1);
    
    [opt, idx] = sort(h, 'descend');
    
    compt = 1;
    t     = 1.2;
    dist  = 50; 
    
    for k=1:4
        if (k==1)||(k > 1 && abs(idx(k-1) - idx(k)) > dist && opt(k)/opt(k-1) < t)
            ratio = opt(k-1)/opt(k);
            compt = compt+1;
            if idx < 50
                L = 1;
                R = 0.05;
            else if idx < 100
                    L = 0.75;
                    R = 0.2;
                else if idx < 150
                        L = 0.2;
                        R = 0.2;
                    else if idx < 200
                            L = 0.2;
                            R = 0.75;
                        else
                            L = 0.05;
                            R = 1;
                        end
                    end
                end
            end
            temp_H = hsGauss(L, R);
            H = (H*(compt-1) + ratio*temp_H)/compt;
        end
    end
    
end
