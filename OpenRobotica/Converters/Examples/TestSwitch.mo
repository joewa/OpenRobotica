within OpenRobotica.Converters.Examples;
model TestSwitch
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
  Converters.Parts.SwitchDiode switch_l annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-18})));
  Converters.Parts.SwitchDiode switch_h annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,24})));
  Converters.Blocks.TestCtrl testCtrl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,70})));
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
  connect(switch_l.n, constantVoltage.n) annotation (Line(
      points={{-1.83697e-015,-28},{0,-28},{0,-62},{48,-62},{48,-26}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, switch_h.p) annotation (Line(
      points={{48,-6},{48,40},{1.83697e-015,40},{1.83697e-015,34}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch_l.p, switch_h.n) annotation (Line(
      points={{1.83697e-015,-8},{-1.83697e-015,-8},{-1.83697e-015,14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inductor.p, switch_h.n) annotation (Line(
      points={{-40,-1},{-40,6},{-1.83697e-015,6},{-1.83697e-015,14}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(testCtrl.lCtrl, switch_l.control) annotation (Line(
      points={{16,60},{16,-18},{10,-18}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(testCtrl.hCtrl, switch_h.control) annotation (Line(
      points={{18,60},{18,24},{10,24}},
      color={255,0,255},
      smooth=Smooth.None));
end TestSwitch;
