function n_output = selectmaterial(material, lambda0)
    mainpath = pwd;
    cd("Material DataBase\");

    x = lambda0/1000;

    switch lower(material)
        case "air"
            n_output = 1;


        case "sin_Airforce"
            load('nk_SiN_AJA.mat');
            n_output = interp1(nk_SiN(:,1),nk_SiN(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiN(:,1),nk_SiN(:,3),x','linear','extrap');
        case "tio2"
            load('nk_TiO2_Sarkar.mat');
            n_output = interp1(nk_TiO2(:,1),nk_TiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_TiO2(:,1),nk_TiO2(:,3),x','linear','extrap');
        case "tio2_stf"
            load('nk_TiO2_stf.mat');
            n_output = interp1(nk_TiO2(:,1),nk_TiO2(:,2),x','pchip','extrap') + ...
                       1i*interp1(nk_TiO2(:,1),nk_TiO2(:,3),x','pchip','extrap');
        case "si3n4_asrc"
            load('nk_Si3N4_ASRC.mat');
            n_output = interp1(nk_SiN(:,1),nk_SiN(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiN(:,1),nk_SiN(:,3),x','linear','extrap');
        case "sio2_asrc"
            load('nk_SiO2_lemarchand.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap');
        case "sio2_Airforce"
            load('nk_SiO2_AJA.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap');
        case "sio2_unaxis"
            load('nk_SiO2_Unaxis.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap');
        case "sio2_oxford"
            load('nk_SiO2_Oxford.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap');
       case "sio2_stf"
            load('nk_SiO2_stf.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap');
        case "sin_unaxis"
            load('nk_SiN_Unaxis.mat');
            n_output = interp1(nk_SiN(:,1),nk_SiN(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiN(:,1),nk_SiN(:,3),x','linear','extrap');
        case "sin_oxford"
            load('nk_SiN_Oxford.mat');
            n_output = interp1(nk_SiN(:,1),nk_SiN(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiN(:,1),nk_SiN(:,3),x','linear','extrap');
        case "hfo2"
            load('nk_HfO2_Siefke.mat');
            n_output = interp1(nk_HfO2_Siefke(:,1),nk_HfO2_Siefke(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_HfO2_Siefke(:,1),nk_HfO2_Siefke(:,3),x','linear','extrap');
        case "hfo2_stf"
            load('nk_HfO2_stf.mat');
            n_output = interp1(nk_HfO2(:,1),nk_HfO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_HfO2(:,1),nk_HfO2(:,3),x','linear','extrap');
        case "zro2"
            n_output = sqrt(1+1.347091./(1-(0.062543./x).^2) + ...
                               2.117788./(1-(0.166739./x).^2) + ...
                               9.452943./(1-(24.320570./x).^2));
        case "nb2o5"
            load('nk_Na2O5_Lemarchand.mat');
            n_output = interp1(nk_Na2O5(:,1),nk_Na2O5(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Na2O5(:,1),nk_Na2O5(:,3),x','linear','extrap');

        case "si"
            load('nk_Si_Schinke.mat');
            n_output = interp1(nk_Si(:,1),nk_Si(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Si(:,1),nk_Si(:,3),x','linear','extrap');

        case "ta2o5"
            load('nk_Ta2O5_Rodriguez.mat');
            n_output = interp1(nk_Ta2O5(:,1),nk_Ta2O5(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Ta2O5(:,1),nk_Ta2O5(:,3),x','linear','extrap');

        case "bk7"
            n_output = sqrt(1+1.03961212./(1-0.00600069867./x.^2)+ ...
                       0.231792344./(1-0.0200179144./x.^2)+ ...
                       1.01046945./(1-103.560653./x.^2));
        case "ge"
            load('nk_Ge_Ciesielski_2nm.mat');
            n_output = interp1(nk_Ge_Ciesielski_2nm(:,1),nk_Ge_Ciesielski_2nm(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Ge_Ciesielski_2nm(:,1),nk_Ge_Ciesielski_2nm(:,3),x','linear','extrap');

        case "ag"
            load('nk_Ag_Johnson.mat');
            n_output = interp1(nk_Ag_Johnson(:,1),nk_Ag_Johnson(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Ag_Johnson(:,1),nk_Ag_Johnson(:,3),x','linear','extrap');

        case "dye1"
            load('nk_dye_Evros.mat');
            n_output = interp1(nk_dye_Evros(:,1),nk_dye_Evros(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_dye_Evros(:,1),nk_dye_Evros(:,3),x','linear','extrap');
        case "dye2"
            load('nk_dye_pm605tcnq.mat');
            n_output = interp1(nk_dye_pm605tcnq(:,1),nk_dye_pm605tcnq(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_dye_pm605tcnq(:,1),nk_dye_pm605tcnq(:,3),x','linear','extrap');
        case "r6g_1"
            load('nk_R6G_1.mat');
            n_output = interp1(nk_R6G_1(:,1),nk_R6G_1(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_R6G_1(:,1),nk_R6G_1(:,3),x','linear','extrap');
        case "r6g_2"
            load('nk_R6G_2.mat');
            n_output = interp1(nk_R6G_2(:,1),nk_R6G_2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_R6G_2(:,1),nk_R6G_2(:,3),x','linear','extrap')*2;
        case "r6g_4"
            load('nk_R6G_4.mat');
            n_output = interp1(nk_R6G_4(:,1),nk_R6G_4(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_R6G_4(:,1),nk_R6G_4(:,3),x','linear','extrap');
        case "wse2"
            load('nk_WSe2_Hsu.mat');
            n_output = interp1(nk_wse2(:,1),nk_wse2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_wse2(:,1),nk_wse2(:,3),x','linear','extrap');  
        case "ws2"
            load('nk_WS2_Hsu.mat');
            n_output = interp1(nk_ws2(:,1),nk_ws2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_ws2(:,1),nk_ws2(:,3),x','linear','extrap'); 
        case "teo2"
            load('nk_TeO2.mat');
            n_output = interp1(nk_wse2(:,1),nk_wse2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_wse2(:,1),nk_wse2(:,3),x','linear','extrap'); 
        case "lif"
            load('nk_LiF.mat');
            n_output = interp1(nk_wse2(:,1),nk_wse2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_wse2(:,1),nk_wse2(:,3),x','linear','extrap'); 
        case "al2o3"
            load('nk_Al2O3.mat');
            n_output = interp1(nk_SiO2(:,1),nk_SiO2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_SiO2(:,1),nk_SiO2(:,3),x','linear','extrap'); 
       case "mgf2"
            load('nk_MgF2.mat');
            n_output = interp1(nk_MgF2(:,1),nk_MgF2(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_MgF2(:,1),nk_MgF2(:,3),x','linear','extrap'); 
        case "pmma"
            load('nk_pmma_Evros.mat');
            n_output = interp1(nk_PMMA450(:,1),nk_PMMA450(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_PMMA450(:,1),nk_PMMA450(:,3),x','linear','extrap'); 
        case "hybrid_20"
            load('nk_Hybrid_20.mat');
            n_output = interp1(nk_Hybrid(:,1),nk_Hybrid(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Hybrid(:,1),nk_Hybrid(:,3),x','linear','extrap'); 
        case "hybrid_40"
            load('nk_Hybrid_40.mat');
            n_output = interp1(nk_Hybrid(:,1),nk_Hybrid(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Hybrid(:,1),nk_Hybrid(:,3),x','linear','extrap'); 
        case "hybrid_60"
            load('nk_Hybrid_60.mat');
            n_output = interp1(nk_Hybrid(:,1),nk_Hybrid(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Hybrid(:,1),nk_Hybrid(:,3),x','linear','extrap'); 
        case "spacer"
            n_output = 1.616 +  0.005./(x'.^2);
        case "cytop"
            load('nk_Cytop.mat');
            n_output = interp1(nk_Cytop(:,1),nk_Cytop(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Cytop(:,1),nk_Cytop(:,3),x','linear','extrap'); 
        case "au"
           load('nk_Au.mat');
            n_output = interp1(nk_Au(:,1),nk_Au(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Au(:,1),nk_Au(:,3),x','linear','extrap'); 
        case "gzo"
            load('nk_GZO_2.mat');
            n_output = interp1(nk_GZO(:,1),nk_GZO(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_GZO(:,1),nk_GZO(:,3),x','linear','extrap'); 
        case "ab56"
            load('nk_AB56.mat');
            n_output = interp1(nk_AB56(:,1),nk_AB56(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_AB56(:,1),nk_AB56(:,3),x','linear','extrap'); 
        case "ab56_nok"
            load('nk_AB56_nok.mat');
            n_output = interp1(nk_AB56(:,1),nk_AB56(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_AB56(:,1),nk_AB56(:,3),x','linear','extrap');
        case "ab56_ag"
            load('nk_AB56.mat');
            n_ab = interp1(nk_AB56(:,1),nk_AB56(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_AB56(:,1),nk_AB56(:,3),x','linear','extrap'); 
            load('nk_Ag_Johnson.mat');
            n_ag = interp1(nk_Ag_Johnson(:,1),nk_Ag_Johnson(:,2),x','linear','extrap') + ...
                       1i*interp1(nk_Ag_Johnson(:,1),nk_Ag_Johnson(:,3),x','linear','extrap');
            e_ab = n_ab^2;
            e_ag = n_ag^2;
            e_mix = combine(0.4,e_ag,e_ab);
            %disp(e_mix);
            n_output = sqrt(e_mix);
       case "fake_1.1"
           disp(numel(lambda0));
            n_output = ones(numel(lambda0),1)* 1.1;
        otherwise
            error('Unknown material: %s', material);
    end
    n_output = n_output;
    cd(mainpath);
end

function e_mix = combine(f,e_m, e_d)
    e_mix = e_d.*(1+f*(e_m-e_d)/(e_d+(1-f).*(e_m-e_d).*(1/3)));
end