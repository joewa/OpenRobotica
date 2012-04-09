within OpenRobotica.Machines.Xcopter.Examples;
model EngineFreeRunning
  Modelica.Electrical.Analog.Basic.Ground ground;
  Modelica.Mechanics.Rotational.Components.Fixed fixed;
  OpenRobotica.Machines.Xcopter.Engine actuator_MK(
    VaNominal=1,
    wNominal=115,
    Jr=1e-05,
    Js=1e-05);
  OpenRobotica.Sources.Battery battery(vNominal = 11);
  Modelica.Blocks.Sources.Step step(startTime = 0.1, height = 0.4);
  Modelica.Mechanics.Rotational.Sources.Torque torque;
  Modelica.Blocks.Sources.Step step1(startTime = 0.7, height =  -0.05);

equation
  connect(fixed.flange,actuator_MK.support);
  connect(battery.n,ground.p);
  connect(battery.n,actuator_MK.pin_n);
  connect(actuator_MK.pin_p,battery.p);
  connect(step.y,actuator_MK.pwm_cmd);
  connect(torque.flange,actuator_MK.flange_a);
  connect(step1.y,torque.tau);
end EngineFreeRunning;
