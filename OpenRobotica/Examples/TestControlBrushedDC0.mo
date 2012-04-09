within OpenRobotica.Examples;
model TestControlBrushedDC0 "Closed loop with an external controller"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  OpenRobotica.Machines.BrushedDC dcm;
  Sensors.HallDigital123 hallDigital123(Ppz=12);
  Analog.Basic.Ground gnd;
  Analog.Sources.SignalVoltage vsource;
  Rotational.Components.Fixed fixed;
  Rotational.Sensors.SpeedSensor speedSensor;
  OpenRobotica.Interfaces.Fifos.RealArray2Controller myFifo;
                                               //(Nout=3);
equation
  //vsource.v = if time < 0.5 then 0 else 10; //Hier Controller-Modell aufrufen
  connect(myFifo.varin[1], vsource.v);
  connect(myFifo.varout[1], speedSensor.w);
  connect(gnd.p, vsource.n);
  connect(vsource.p, dcm.pin_p);
  connect(vsource.n, dcm.pin_n);
  connect(dcm.pin_n, gnd.p);
  connect(fixed.flange, dcm.support);

  connect(dcm.flange, speedSensor.flange);
  connect(dcm.flange, hallDigital123.flange);
initial equation
  dcm.phiMechanical = 0;
end TestControlBrushedDC0;
