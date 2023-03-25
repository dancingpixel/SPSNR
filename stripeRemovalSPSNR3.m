function out = stripeRemovalSPSNR3(im, NMF0, NME0)

    im = double(im);
    pixs = im(not(isnan(im)));
    avg = mean(pixs(:));
	stds = std(pixs(:));
    maxpixs = max(pixs(:));
    
    NMF = ceil((abs(stds)/maxpixs)*NMF0);
    NMF         = max([1 NMF]);

    
    IMF         = movmedian(im,NMF,2,'omitnan');
    MFNoise     = (im-IMF)  ; 
    MFNoise(isnan(im))=NaN;   
    
    Nnz   = numel(MFNoise((MFNoise~=0)&(not(isnan(MFNoise))))) ;
    Npix  = not(isnan(MFNoise));
    Npix  = sum(Npix(:));
    NME         = ceil((Nnz/Npix) * NME0);
    NME         = max([1 NME]);
    
    MENoise     = movmean(MFNoise, NME, 1,'omitnan');
    out         = im - MENoise ;
    out(isnan(im))=NaN;   
    
    
%     disp('############')
%     disp(['NMF ' num2str(NMF)])
%     disp(['NME ' num2str(NME)])
    
    