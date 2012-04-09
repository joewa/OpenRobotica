within OpenRobotica.Interfaces;
package Events "Interfaces for Discrete Event Systems"
 partial model BasicDEVSTwoPort

  import Modelica.Constants.inf;       // import constant inf
  input EventPort inp;                 // Input port for external events
  output EventPort outp;               // Output port for emitted events
  Boolean DEVSactive(  start=false);    // Start in non-active mode (phase)
  Real tResidual(     start=inf);        // Time until internal event (sigma)
  Real tlocal(     start=0);             // Local timer reset at events (e)
  discrete Real tNextEvent(start=0.0001);     // Time of next internal event
  discrete Real tLastEvent(start=0);       // Time of most recent event
 equation
  tResidual = if tNextEvent<time then 
                    inf else   tNextEvent-time;
                                 // tNextEvent==inf
  tlocal = if inp.signal or tNextEvent<=time then 
                0 else time - tLastEvent;    // extern or intern ev
  when {inp.signal, pre(tNextEvent)<=time} then
    tLastEvent = time;                     // Note the time of this event
  end when;
 end BasicDEVSTwoPort;
end Events;
