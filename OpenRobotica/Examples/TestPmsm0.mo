within OpenRobotica.Examples;
model TestPmsm0 "Does Machines.PMSM work?"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  OpenRobotica.Machines.PMSM pmsm;
  Analog.Basic.Ground gnd;
  Analog.Sources.SignalVoltage vsource;
  Rotational.Fixed fixed;
equation
  vsource.v = if time < 0.5 then 0 else 10;
  connect(gnd.p, vsource.n);
  connect(vsource.p, pmsm.a1);
  connect(vsource.n, pmsm.a2);
  connect(pmsm.b1, pmsm.b2);
  connect(pmsm.b2, gnd.p);
  connect(pmsm.c1, pmsm.c2);
  connect(pmsm.c2, gnd.p);
  connect(fixed.flange_b, pmsm.support);
//initial equation
//  pmsm.phiMechanical = 0;
end TestPmsm0;
