within OpenRobotica.Robots.Xcopter.Parts;
model Propeller "Propeller a/c body interface, actuated by 1-dim power trains"
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Polygon(
          points={{100,80},{96,96},{80,100},{16,22},{2,0},{24,14},{100,82},{100,
              80}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{49,30},{45,46},{29,50},{-35,-28},{-49,-50},{-27,-36},{49,32},
              {49,30}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-51,-50},
          rotation=180),
        Ellipse(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360)}), Diagram(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics));

  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,1,0}
    "Axis of rotation resolved in frame_a (= same as in frame_b)";
  parameter Modelica.SIunits.Inertia jrot=0.001
    "Inertia of propeller and motor";

  // Mechanical connectors
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a annotation (Placement(
        transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={-60,-70}),iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,0})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "Connects motor shaft and propeller"                   annotation (
      Placement(transformation(extent={{-10,30},{10,50}}), iconTransformation(
          extent={{-10,30},{10,50}})));
  Modelica.Mechanics.Rotational.Interfaces.Support support
    "Connects motor housing to a/c frame"                  annotation (
      Placement(transformation(extent={{-10,-50},{10,-30}}),
        iconTransformation(extent={{-10,-50},{10,-30}})));
  // Internal elements
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n=n) 
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Mechanics.MultiBody.Parts.Rotor1D rotor(n=n, J=jrot,
    animation=false)                                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,40})));
  // Interface to the air
  // Ueberlege die wechselwirkungen "outer" zu machen
  Modelica.Mechanics.Rotational.Sources.Torque airtorque annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,40})));
  Modelica.Blocks.Sources.Constant const(k=0) 
    annotation (Placement(transformation(extent={{-100,72},{-80,92}})));
equation
  connect(mounting1D.frame_a, frame_a) annotation (Line(
      points={{-40,-50},{-40,-60},{-60,-60},{-60,-70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(support, mounting1D.flange_b) annotation (Line(
      points={{0,-40},{-30,-40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(rotor.frame_a, frame_a) annotation (Line(
      points={{-40,30},{-60,30},{-60,-70}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(flange, rotor.flange_b) annotation (Line(
      points={{0,40},{-30,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(airtorque.flange, rotor.flange_a) annotation (Line(
      points={{-62,40},{-50,40}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(const.y, airtorque.tau) annotation (Line(
      points={{-79,82},{-76,82},{-76,60},{-84,60},{-84,40}},
      color={0,0,127},
      smooth=Smooth.None));
end Propeller;
