%Currently SLOWER than ART
function [Rs,Rp,Ts,Tp,Ms,Ds,Mp,Dp,kx,n,beta,P,d,k0] = ART_GPU(d,lambda0,theta0,n_structure)

    % --- sizes ---
    L = numel(lambda0);
    M = numel(theta0);
    N = numel(d);


    n_cpu = zeros(L,length(n_structure));
    for i = 1:length(n_structure)
        n_cpu(:,i) = selectmaterial(n_structure(i), lambda0);
    end

    lambda0 = gpuArray(lambda0);
    theta0  = gpuArray(theta0);
    d       = gpuArray(d);
    n       = gpuArray(n_cpu);


    [lambda_grid, theta_grid] = ndgrid(lambda0, theta0);

    k0 = 2*pi ./ lambda_grid; % L x M

    % expand n → L x M x N

    n = permute(n, [1 3 2]); % L x 1 x N
    n = repmat(n, [1 M 1]);  % L x M x N

    kx = zeros(N,L,M);
    beta = n(:,:,1) .* k0 .* sin(theta_grid);

    Ms = repmat(gpuArray.eye(2),1,1,L,M);
    Mp = Ms;
    P = zeros(N,2,2,L,M,'gpuArray');
    Ds = zeros(N,2,2,L,M,'gpuArray');
    Dp = zeros(N,2,2,L,M,'gpuArray');
    for c = 1:N-1

        nc  = n(:,:,c);
        nc1 = n(:,:,c+1);

        kx(c,:,:) = sqrt(complex((nc.*k0).^2 - beta.^2));
        ti = asin(complex(n(:,:,1)).*sin(theta_grid)./nc);
        tt = asin(complex(n(:,:,1)).*sin(theta_grid)./nc1);

        % --- Ds ---
        A = (nc.*cos(ti) + nc1.*cos(tt)) ./ (2*nc.*cos(ti));
        B = (nc.*cos(ti) - nc1.*cos(tt)) ./ (2*nc.*cos(ti));

        
        Ds(c,1,1,:,:) = A;
        Ds(c,1,2,:,:) = B;
        Ds(c,2,1,:,:) = B;
        Ds(c,2,2,:,:) = A;

        % --- Dp ---
        A = (nc1.*cos(ti) + nc.*cos(tt)) ./ (2*nc.*cos(ti));
        B = (nc1.*cos(ti) - nc.*cos(tt)) ./ (2*nc.*cos(ti));


        Dp(c,1,1,:,:) = A;
        Dp(c,1,2,:,:) = B;
        Dp(c,2,1,:,:) = B;
        Dp(c,2,2,:,:) = A;

        % --- propagation ---
        phi = squeeze(kx(c,:,:)) .* d(c);
        P(c,1,1,:,:) = exp(-1i*phi);
        P(c,2,2,:,:) = exp( 1i*phi);
        % --- GPU batched multiply ---
        Ms = pagemtimes(Ms, pagemtimes(squeeze(P(c,:,:,:,:)), squeeze(Ds(c,:,:,:,:))));
        Mp = pagemtimes(Mp, pagemtimes(squeeze(P(c,:,:,:,:)), squeeze(Dp(c,:,:,:,:))));
    end

    Ms11 = squeeze(Ms(1,1,:,:));
    Ms21 = squeeze(Ms(2,1,:,:));
    Mp11 = squeeze(Mp(1,1,:,:));
    Mp21 = squeeze(Mp(2,1,:,:));

    Rs = abs(Ms21 ./ Ms11).^2;
    Rp = abs(Mp21 ./ Mp11).^2;

    theta_out = asin(complex(n(:,:,1)).*sin(theta_grid)./n(:,:,N));

    Ts = (real(n(:,:,N).*cos(theta_out)) ./ real(n(:,:,1).*cos(theta_grid))) ...
         .* abs(1./Ms11).^2;

    Tp = (real(n(:,:,N).*cos(theta_out)) ./ real(n(:,:,1).*cos(theta_grid))) ...
         .* abs(1./Mp11).^2;

    Rs = gather(Rs);
    Rp = gather(Rp);
    Ts = gather(Ts);
    Tp = gather(Tp);
    d = gather(d);
    n = gather(n);
    Ds = gather(Ds);
    Dp = gather(Dp);
    P = gather(P);
    k0 = gather(k0);
    beta = gather(beta);
end