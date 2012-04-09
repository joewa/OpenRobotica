within OpenRobotica.Interfaces;
package MotorControl "Interfaces to motorcontrolif.a"

  function sampleCurrentController3ph "Sample "
  // Blocks and waits for new reference values, if modelicatime == nextSample.
  // If an event was captured, the reference values may be updated;
    input Real t;
    input Real phi_el;
    input Real i_a;
    input Real i_b;
    input Real i_c;
    output Real nextSample;
  external "C" 
    nextSample=   extSampleCurrentController3ph(t, phi_el, i_a, i_b, i_c) annotation(Library="motorcontrolif.a",
                            Include="#include \"motorcontrolif.h\"");
           //"C"
  end sampleCurrentController3ph;

  function sampleMotionController
  // Blocks and waits for new reference values, if modelicatime == nextSample
  // If an event was captured, the reference values may be updated;
    input Real t;
    input Real w_mech;
    input Real phi_mech;
    output Real nextSample; //Braucht Modelica nicht zu wissen
    output Real t_mech;
  external "C" 
    nextSample=   extSampleSpeed(t, w_mech, phi_mech) annotation(Library="motorcontrolif.a",
                            Include="#include \"motorcontrolif.h\"");
           //"C"
  end sampleMotionController;

  function capture1 "Capture hall sensor event"
  //Here, modelica schedules an event at time t. The function blocks until time t has been reached
  //and the event has been processed. In consequence, an event may be scheduled (unmittelbar) at a controller
  //(to update reference vals) -> controller blocks then
    input Real t;
    input Real val;
    // output Real nextSample;
  external "C"            extCapture1(t, vall) annotation(Library="motorcontrolif.a",
                            Include="#include \"motorcontrolif.h\"");
    //nextSample =
           //"C"
  end capture1;

  function capture2 "Capture event"
  //Here, the simulation schedules an event at time t
    input Real t;
    input Real val;
    // output Real nextSample;
  external "C"            extCapture2(t, vall) annotation(Library="motorcontrolif.a",
                            Include="#include \"motorcontrolif.h\"");
    //nextSample =
           //"C"
  end capture2;

  function capture3 "Capture event"
  //Here, the simulation schedules an event at time t
    input Real t;
    input Real val;
    // output Real nextSample;
  external "C"            extCapture3(t, vall) annotation(Library="motorcontrolif.a",
                            Include="#include \"motorcontrolif.h\"");
    //nextSample =
           //"C"
  end capture3;
end MotorControl;
