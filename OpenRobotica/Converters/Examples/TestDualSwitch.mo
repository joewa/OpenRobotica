within OpenRobotica.Converters.Examples;
model TestDualSwitch
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=1e-2) 
                                                     annotation (Placement(
        transformation(
        extent={{-10,-11},{10,11}},
        rotation=270,
        origin={-40,-11})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-50,-82},{-30,-62}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),      graphics));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=10) 
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,-16})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-42})));
  Converters.Blocks.TestCtrl testCtrl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,70})));
  Converters.Parts.DualSwitchDiode dualSwitchDiode annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,10})));
equation
  connect(constantVoltage.n, ground.p) annotation (Line(
      points={{48,-26},{48,-62},{-40,-62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.p, inductor.n) annotation (Line(
      points={{-40,-32},{-40,-21}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.n, ground.p) annotation (Line(
      points={{-40,-52},{-40,-62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dualSwitchDiode.n, ground.p) annotation (Line(
      points={{-1.83697e-015,0},{0,0},{0,-62},{-40,-62}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dualSwitchDiode.p, constantVoltage.p) annotation (Line(
      points={{1.83697e-015,20},{1.83697e-015,28},{48,28},{48,-6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(dualSwitchDiode.pin, inductor.p) annotation (Line(
      points={{-10,10},{-40,10},{-40,-1}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(testCtrl.hCtrl, dualSwitchDiode.hCtrl) annotation (Line(
      points={{18,60},{18,15},{10.6,15}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(testCtrl.lCtrl, dualSwitchDiode.lCtrl) annotation (Line(
      points={{16,60},{16,5},{10.6,5}},
      color={255,0,255},
      smooth=Smooth.None));
end TestDualSwitch;
