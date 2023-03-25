function out = stripeRemovalOSNR(im, NMF0, NME0)

    IMF         = movmedian(im,NMF0,2,'omitnan');
    MFNoise     = (im-IMF)  ; 
    MFNoise(isnan(im))=NaN;   
    
    MENoise     = movmean(MFNoise, NME0, 1,'omitnan');
    out         = im - MENoise ;
    out(isnan(im))=NaN;   
    
    