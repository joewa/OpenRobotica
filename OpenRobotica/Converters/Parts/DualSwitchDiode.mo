within OpenRobotica.Converters.Parts;
model DualSwitchDiode
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  parameter Modelica.SIunits.Resistance RonSwitch=1e-5 "Ron of Switch";
  parameter Modelica.SIunits.Conductance GoffSwitch=1e-5 "Gon of Switch";
  parameter Modelica.SIunits.Resistance RonDiode=1e-5 "Ron of Diode";
  parameter Modelica.SIunits.Conductance GoffDiode=1e-5 "Gon of Diode";
  SwitchDiode hSwitchDiode(
    RonSwitch=RonSwitch,
    RonDiode=RonDiode,
    GoffSwitch=GoffSwitch,
    GoffDiode=GoffDiode) 
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  SwitchDiode lSwitchDiode(
    RonSwitch=RonSwitch,
    GoffSwitch=GoffSwitch,
    RonDiode=RonDiode,
    GoffDiode=GoffDiode) 
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin pin 
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.BooleanInput hCtrl annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-50,106})));
  Modelica.Blocks.Interfaces.BooleanInput lCtrl annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={50,106})));
  annotation (Diagram(graphics));
equation
  connect(p, hSwitchDiode.p) annotation (Line(
      points={{-100,0},{-60,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lSwitchDiode.n, n) annotation (Line(
      points={{60,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hSwitchDiode.n, pin) annotation (Line(
      points={{-40,0},{0,0},{0,-100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(lSwitchDiode.p, pin) annotation (Line(
      points={{40,0},{0,0},{0,-100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(hCtrl, hSwitchDiode.control) annotation (Line(
      points={{-50,106},{-50,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lCtrl, lSwitchDiode.control) annotation (Line(
      points={{50,106},{50,10}},
      color={255,0,255},
      smooth=Smooth.None));
end DualSwitchDiode;
