within OpenRobotica.Sensors;
model HallDigital123 "3 hall sensors"
   import Modelica.Constants.pi;
   parameter Modelica.SIunits.Angle hall_angle[3]={0, 2/3*pi, 4/3*pi}
    "Hall sensor is mounted at this electrical angle and outputs true";
   parameter Real Ppz=1 "Sensor pairs of poles";
   Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "flange to be measured"                                                 annotation (Placement(transformation(x=-100.,y=0.,scale=0.1,aspectRatio=1.),iconTransformation(x=-100.,y=0.,scale=0.1,aspectRatio=1.)));
   Modelica.Mechanics.Rotational.Components.IdealGear hallGear(ratio = Ppz)
    "Virtual gear to provide the pairs of poles property";
   OpenRobotica.Sensors.HallDigital hallA(hall_angle=hall_angle[1]);
   OpenRobotica.Sensors.HallDigital hallB(hall_angle=hall_angle[2]);
   OpenRobotica.Sensors.HallDigital hallC(hall_angle=hall_angle[3]);
   Modelica.Blocks.Interfaces.RealOutput y[3] annotation (Placement(transformation(x=110.,y=0.,scale=0.1,aspectRatio=1.,Hide=true),iconTransformation(x=110.,y=0.,scale=0.1,aspectRatio=1.,Hide=true)));
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
   connect(flange, hallGear.flange_b);
   connect(hallGear.flange_a, hallA.flange);
   connect(hallGear.flange_a, hallB.flange);
   connect(hallGear.flange_a, hallC.flange);
   connect(hallA.y, y[1]);
   connect(hallB.y, y[2]);
   connect(hallC.y, y[3]);
end HallDigital123;
