within OpenRobotica.Converters.Parts;
model Zsource
  //extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 
    annotation (Placement(transformation(extent={{-110,-60},{-90,-40}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 
    annotation (Placement(transformation(extent={{90,-60},{110,-40}})));

  parameter Modelica.SIunits.Inductance L1;
  parameter Modelica.SIunits.Capacitance C1;
  parameter Modelica.SIunits.Inductance L2;
  parameter Modelica.SIunits.Capacitance C2;

  Modelica.Electrical.Analog.Basic.Inductor l1(L=L1) 
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Basic.Inductor l2(L=L2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-50})));
  Modelica.Electrical.Analog.Basic.Capacitor c1(C=C1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,10})));
  Modelica.Electrical.Analog.Basic.Capacitor c2(C=C1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,10})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}),
                      graphics));
equation
  connect(l1.p, p1) annotation (Line(
      points={{-10,50},{-100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c1.p, p1) annotation (Line(
      points={{-30,20},{-30,50},{-100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(l1.n, p2) annotation (Line(
      points={{10,50},{100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c2.p, p2) annotation (Line(
      points={{30,20},{30,50},{100,50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(l2.n, n1) annotation (Line(
      points={{-10,-50},{-100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c2.n, n1) annotation (Line(
      points={{30,0},{-20,0},{-20,-50},{-100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(l2.p, n2) annotation (Line(
      points={{10,-50},{100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c1.n, n2) annotation (Line(
      points={{-30,0},{-30,-20},{20,-20},{20,-50},{100,-50}},
      color={0,0,255},
      smooth=Smooth.None));
end Zsource;
