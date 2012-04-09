within OpenRobotica.Sensors;
model HallDigital "Digital hall sensor"
   import Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle hall_angle=0
    "Hall sensor is mounted at this electrical angle and outputs true";
   Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "flange to be measured"                                                 annotation (Placement(transformation(x=-100.,y=0.,scale=0.1,aspectRatio=1.),iconTransformation(x=-100.,y=0.,scale=0.1,aspectRatio=1.)));
   Modelica.SIunits.Angle phi_el;
   Real y_inside;
   Modelica.Blocks.Interfaces.RealOutput y    annotation (Placement(transformation(x=110.,y=0.,scale=0.1,aspectRatio=1.,Hide=true),iconTransformation(x=110.,y=0.,scale=0.1,aspectRatio=1.,Hide=true)));
   annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100.,100.},{100.,-100.}},
          lineColor={0,0,0},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150.,-140.},{150.,-110.}},
          fillColor={0,0,0},
          textString="%threshold"),
        Ellipse(
          extent={{71.,7.},{85.,-7.}},
          lineColor={235,235,235},
          fillColor={235,235,235},
          fillPattern=FillPattern.Solid)}),                                                                                                    Diagram(coordinateSystem(extent={{-100.,-100.},{100.,100.}})));
equation
   phi_el = flange.phi;
   0 = flange.tau;
   //y_inside = if sin( phi_el + hall_angle - pi/2) > 0 then 1 else 0; // funzt nicht
   y_inside = sin( phi_el + hall_angle + pi/2);
   y = if y_inside <= 0.0 then 0 else 1; // funzt
end HallDigital;
