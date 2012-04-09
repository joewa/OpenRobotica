within OpenRobotica.Robots.Xcopter.Examples;
model BodyFreeFall "Body in free fall"

  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics));
  inner Modelica.Mechanics.MultiBody.World world 
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(animation=false, m=1) 
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotion freeMotion
    annotation (Placement(transformation(extent={{-58,-100},{-38,-80}})));
equation
  connect(world.frame_b, freeMotion.frame_a) annotation (Line(
      points={{-80,-90},{-58,-90}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(freeMotion.frame_b, body.frame_a) annotation (Line(
      points={{-38,-90},{-20,-90}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
end BodyFreeFall;
