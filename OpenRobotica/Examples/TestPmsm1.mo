within OpenRobotica.Examples;
model TestPmsm1
  "Attach Hall Sensors and, rotate its shaft and watch flux shape vs hall output"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  OpenRobotica.Machines.PMSM pmsm;
  Sensors.HallDigital123 hallDigital123(Ppz=12);
  Analog.Basic.Ground gnd;
  Analog.Sources.SignalVoltage vsource;
  Rotational.Fixed fixed;
  Rotational.Speed speed;
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
  connect(pmsm.flange, hallDigital123.flange_a);
  speed.w_ref = 2;
  connect(pmsm.flange, speed.flange_b);
//initial equation
//  pmsm.phiMechanical = 0;
end TestPmsm1;
