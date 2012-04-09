within OpenRobotica.Examples;
model TestControlPMSM "Closed loop with an external controller"
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  OpenRobotica.Machines.BrushedDC dcm;
  OpenRobotica.Sensors.HallDigital123 hallDigital123;
  Real hallout[3];
  Analog.Basic.Ground gnd;
  Analog.Sources.SignalVoltage vsource;
  Rotational.Fixed fixed;
  Rotational.Sensors.SpeedSensor speedSensor;

  OpenRobotica.Interfaces.Fifos.RealArray2ControllerOld myFifo;
                                               //(Nout=3);
equation
  //vsource.v = if time < 0.5 then 0 else 10; //Hier Controller-Modell aufrufen
  connect(myFifo.varin[1], vsource.v);
  connect(myFifo.varout[1], speedSensor.w);
  //myFifo.interrupt = change(hallSensorA.y);

  //myFifo.varout[1] = 13.5;
  //myFifo.varout[3] = 15.5;
  connect(gnd.p, vsource.n);
  connect(vsource.p, dcm.pin_p);
  connect(vsource.n, dcm.pin_n);
  connect(dcm.pin_n, gnd.p);
  connect(fixed.flange_b, dcm.support);
  connect(dcm.flange, speedSensor.flange_a);
  connect(dcm.flange, hallDigital123.flange_a);
  hallout = hallDigital123.y;
  //hallout = if hallSensorA.y then 1 else 0;
  //hallout = hallSensorA.y;
initial equation
  dcm.phiMechanical = 0;
end TestControlPMSM;
