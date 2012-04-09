within OpenRobotica.Machines.Xcopter.Examples;
model TestEngineCL
  annotation(Diagram(coordinateSystem(extent = {{ -100, -100},{100,100}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  OpenRobotica.Machines.Xcopter.Engine actuator_MK(
    VaNominal=1,
    wNominal=115,
    Jr=1e-05,
    Js=1e-05)                                                                                  annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  OpenRobotica.Sources.Battery battery(vNominal = 11) 
                                               annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  Modelica.Blocks.Sources.Step step1(startTime = 0.7, height =  -0.05) annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  OpenRobotica.Machines.Xcopter2.Computers.TestCtrl testCtrl(
                                      Ts = 0.001, K = 0.01, Ref = 500) annotation(Placement(transformation(scale = 1.0), iconTransformation(scale = 1.0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 1, uMin = 0) annotation(Placement(transformation(scale = 1.0, rotation = 180.0), iconTransformation(scale = 1.0)));

equation
  connect(fixed.flange,actuator_MK.support) annotation(Line(points={{0.5,0.5},{
          0.5,3.62625},{-8.9975,3.62625},{-8.9975,6.7525},{0,6.7525},{0,0.1}},              color = {0,0,0}, smooth = Smooth.None));
  connect(battery.n,ground.p) annotation(Line(points={{1,0.5},{1,-8.625},{-2.5,
          -8.625},{-2.5,-17.75},{0.5,-17.75},{0.5,1}},                  color = {0,0,255}, smooth = Smooth.None));
  connect(battery.n,actuator_MK.pin_n) annotation(Line(points={{1,0.5},{12,
          0.5},{12,1},{0.3,1}},                                                                 color = {0,0,255}, smooth = Smooth.None));
  connect(actuator_MK.pin_p,battery.p) annotation(Line(points={{0.7,1},{0.7,
          66},{0,66},{0,0.5}},                                                                        color = {0,0,255}, smooth = Smooth.None));
  connect(torque.flange,actuator_MK.flange_a) annotation(Line(points={{1,0.5},
          {-1.49875,0.5},{-1.49875,5.0025},{-3.9975,5.0025},{-3.9975,0.5},{
          0,0.5}},                                                                            color = {0,0,0}, smooth = Smooth.None));
  connect(step1.y,torque.tau) annotation(Line(points={{1.05,0.5},{-54,0.5},{-54,
          0.5},{-0.1,0.5}},                                                                             color = {0,0,127}, smooth = Smooth.None));
  connect(speedSensor.flange,actuator_MK.flange_a) annotation(Line(points={{0,0.5},
          {2,0.5},{2,0.5},{0,0.5}},                                                                               color = {0,0,0}, smooth = Smooth.None));
  connect(speedSensor.w,testCtrl.u) annotation(Line(points={{1.05,0.5},{-9.0325,
          0.5},{-9.0325,61},{-19.115,61},{-19.115,0.5},{-0.04,0.5}},                  color = {0,0,127}, smooth = Smooth.None));
  connect(limiter.y,actuator_MK.pwm_cmd) annotation(Line(points={{-0.05,0.5},{
          35.5,0.5},{35.5,0.5},{1,0.5}},                                                                     color = {0,0,127}, smooth = Smooth.None));
  connect(testCtrl.y,limiter.u) annotation(Line(points={{1.03,0.5},{72,0.5},{72,
          0.5},{1.1,0.5}},                                                                          color = {0,0,127}, smooth = Smooth.None));
end TestEngineCL;
