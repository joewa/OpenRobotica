within OpenRobotica.Robots.Xcopter.Examples;
model PropellerSpring "Test the propeller inertia against a spring"

  Parts.Propeller propeller
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Mechanics.Rotational.Components.Spring spring
    annotation (Placement(transformation(extent={{8,-36},{28,-16}})));
equation
  connect(world.frame_b, propeller.frame_a) annotation (Line(
      points={{-80,-90},{-46,-90},{-46,-30},{-10,-30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(propeller.flange, spring.flange_a) annotation (Line(
      points={{-10,-26},{8,-26}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(propeller.support, spring.flange_b) annotation (Line(
      points={{-10,-34},{6,-34},{6,-40},{28,-40},{28,-26}},
      color={0,0,0},
      smooth=Smooth.None));
initial equation
  spring.phi_rel = 1;
end PropellerSpring;
