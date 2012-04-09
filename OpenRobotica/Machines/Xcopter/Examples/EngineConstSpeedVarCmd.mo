within OpenRobotica.Machines.Xcopter.Examples;
model EngineConstSpeedVarCmd "Produce current/torque at constant speed"
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),      graphics));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-10,18},{10,38}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed 
    annotation (Placement(transformation(extent={{0,-38},{20,-18}})));
  OpenRobotica.Machines.Xcopter.Engine engine_MK(
    Jr=0.0001,
    VaNominal=1,
    wNominal=115,
    Js=0.00001) 
    annotation (Placement(transformation(extent={{10,-14},{30,6}})));
  OpenRobotica.Sources.Battery battery(vNominal=11) 
    annotation (Placement(transformation(extent={{-20,42},{0,62}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        500) 
    annotation (Placement(transformation(extent={{-48,-14},{-28,6}})));
  Modelica.Blocks.Sources.Ramp ramp(height=1, duration=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-70})));
equation
  connect(battery.n, ground.p) annotation (Line(
      points={{0,52},{0,38}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(battery.n, engine_MK.pin_n) annotation (Line(
      points={{0,52},{8,52},{8,6},{16,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(battery.p, engine_MK.pin_p) annotation (Line(
      points={{-20,52},{-20,74},{24,74},{24,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(fixed.flange, engine_MK.support) annotation (Line(
      points={{10,-28},{10,-12}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(constantSpeed.flange, engine_MK.flange_a) annotation (Line(
      points={{-28,-4},{10,-4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(ramp.y, engine_MK.pwm_cmd) annotation (Line(
      points={{21,-70},{34,-70},{34,-4},{30,-4}},
      color={0,0,127},
      smooth=Smooth.None));
end EngineConstSpeedVarCmd;
