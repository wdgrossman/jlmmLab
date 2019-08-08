function contactList=makeCoarseContactList(tle, gs, clProps,t0,tf)

switch nargin
    case 3
         contactList=getContactTimesKernal(tle,gs, clProps,'coarse');
   
    case 4
        if isempty(t0)
         contactList=getContactTimesKernal(tle,gs, clProps,'coarse');
        else
            contactList=getContactTimesKernal(tle,gs, clProps,'coarse',t0);
        end
         
    case 5
         contactList=getContactTimesKernal(tle,gs, clProps,'coarse',t0,tf);
        
    otherwise
        error('Wrong number of inputs')
end %switch
end %function