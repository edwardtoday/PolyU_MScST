function myWait(DeltaT)
if(DeltaT>0) %end condition
    t=timer('timerfcn','myWait(0)','StartDelay',DeltaT);
    start(t);
    wait(t);
end