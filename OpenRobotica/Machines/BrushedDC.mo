within OpenRobotica.Machines;
model BrushedDC "Simple DC-Machine model"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.SIunits;
  parameter SIunits.Inertia Jr=27e-3 "Inertia of the rotor";
  parameter SIunits.Inertia Js=1 "Inertia of the stator";
  parameter SIunits.Resistance R_p=0.54 "Per phase resistance";
  parameter SIunits.Inductance L_p=1.45e-3 "Per phase inductance";
  parameter SIunits.MagneticFlux Bemf=1.04 "Back EMF constant [VS/rad]";

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
    annotation (extent=[-110,30; -90,50]);
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    annotation (extent=[-110,-50; -90,-30]);
  annotation (Diagram);
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
    annotation (extent=[90,-10; 110,10]);
  Modelica.Mechanics.Rotational.Interfaces.Flange_b support 
    annotation (extent=[90,-88; 110,-68]);
  output SIunits.Angle phiMechanical = flange.phi-support.phi;
  output SIunits.AngularVelocity wMechanical(displayUnit="1/min") = der(phiMechanical);
  Rotational.Components.Inertia inertia_rotor(J=Jr);
  Rotational.Components.Inertia inertia_housing(J=Js);
  Rotational.Sources.Torque2 torque2;
  Analog.Basic.Resistor r_a(R=R_p);
  Analog.Basic.Inductor l_a(L=L_p);
  Analog.Sources.SignalVoltage emf;
equation
  //Electrical network
  connect(pin_n, r_a.p);
  connect(r_a.n, l_a.p);
  connect(l_a.n, emf.p);
  connect(emf.n, pin_p);
  //Electrical <=> mechanical
  emf.v = -wMechanical * Bemf;
  torque2.tau = Bemf * pin_n.i;
  //Mechanical stuff
  connect(flange, inertia_rotor.flange_a);
  connect(inertia_rotor.flange_b, torque2.flange_a);
  connect(torque2.flange_b, inertia_housing.flange_a);
  connect(inertia_housing.flange_b, support);

end BrushedDC;
