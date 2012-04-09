within OpenRobotica.Examples;
model TestBrushedDC0 "Does the BrushedDC work?"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  OpenRobotica.Machines.BrushedDC dcm;
  Analog.Basic.Ground gnd;
  Analog.Sources.SignalVoltage vsource;
  Rotational.Fixed fixed;
equation
  vsource.v = if time < 0.5 then 0 else 10;
  connect(gnd.p, vsource.n);
  connect(vsource.p, dcm.pin_p);
  connect(vsource.n, dcm.pin_n);
  connect(dcm.pin_n, gnd.p);
  connect(fixed.flange_b, dcm.support);
initial equation
  dcm.phiMechanical = 0;
end TestBrushedDC0;
