within OpenRobotica.Converters.Parts;
model SwitchDiode
  extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  parameter Modelica.SIunits.Resistance RonSwitch=1e-5 "Ron of Switch";
  parameter Modelica.SIunits.Conductance GoffSwitch=1e-5 "Gon of Switch";
  parameter Modelica.SIunits.Resistance RonDiode=1e-5 "Ron of Diode";
  parameter Modelica.SIunits.Conductance GoffDiode=1e-5 "Gon of Diode";

  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch(Ron=
        RonSwitch, Goff=GoffSwitch) 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode(Ron=RonDiode, Goff=
        GoffDiode) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-30})));
  Modelica.Blocks.Interfaces.BooleanInput control annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
equation
  connect(idealClosingSwitch.p, p) annotation (Line(
      points={{-10,0},{-100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode.n, p) annotation (Line(
      points={{-10,-30},{-56,-30},{-56,0},{-100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealClosingSwitch.n, n) annotation (Line(
      points={{10,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealDiode.p, n) annotation (Line(
      points={{10,-30},{56,-30},{56,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(control, idealClosingSwitch.control) annotation (Line(
      points={{0,100},{0,7}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end SwitchDiode;
