within OpenRobotica.Sources;
model Battery
extends Modelica.Electrical.Analog.Interfaces.TwoPin;
  parameter Modelica.SIunits.Voltage vNominal=11;
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation

  annotation (Diagram(graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{10,40},{24,-40}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-24,80},{-10,-80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
  connect(p, signalVoltage.p) annotation (Line(
      points={{-100,0},{-10,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalVoltage.n, n) annotation (Line(
      points={{10,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  signalVoltage.v = vNominal;
end Battery;
