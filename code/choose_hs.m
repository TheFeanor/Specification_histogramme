function H = choose_hs(im)
    h=hist(im(:),256); h=h/numel(im);
    H = zeros(256, 1);

    [opt, idx] = sort(h, 'descend');

    compt = 1;
    dist  = 50;
    former_idx = 1000*ones(10,1);
    j=1;

    for k=1:100
        new_idx = ones(10,1)*idx(k);
        test = 1;
        for i=1:10
            if abs(new_idx(i) - former_idx(i)) < dist
                test = 0;
            end
        end
        if (k==1) || test == 1
          % choisir la forme de l'approximation (gaussienne ou laplacienne) en fonction
          % de l'allure du pic détecté
          mid_val = -1;
          if idx(k) > 30 || idx(k) < 30
              inter_idx = (idx(k)-30):(idx(k)+30);
          elseif idx(k) < 30
              iter_idx = 1:(idx(k)+30);
          else
              inter_idx = (idx(k)-30):256
          mid_id  = inter_idx(opt(inter_idx)==opt(k)/2);
          if sum(mid_id > 0)
              mid_val = opt(mid_id)
              mid_val = min(abs(mid_val-idx(k)));

          % si la valeur du milieu n'est pas dans l'intervalle d'intérêt
          if mid_val == -1
              type = 'gau';
          else
              if abs(mid_val-idx <15)
                 type = 'lap';
              else
                  type = 'gau';
              end
          end

          % trouver la meilleure position pour le pic
            ratio = opt(k)/opt(1);
            compt = compt+1;
            former_idx(j) = idx(k);
            j = j+1;
            if idx(k) < 50
                L = 1;
                R = 0.05;
            elseif idx(k) < 100
                L = 0.75;
                R = 0.2;
            elseif idx(k) < 150
                L = 0.2;
                R = 0.2;
            elseif idx(k) < 200
                L = 0.2;
                R = 0.75;
            else
                L = 0.05;
                R = 1;
            end
        temp_H = hsGauss(L, R);
        H = max(H,ratio*temp_H);
        %(H*(compt-1) + ratio*temp_H)/compt;
        figure;
        bar([0:1:255],temp_H);xlim([0,255])
        figure;
        bar([0:1:255],H);xlim([0,255])
        end

    end


end
