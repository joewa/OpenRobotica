within OpenRobotica.Machines;
partial model PartialBasicMachine "Partial model for all machines"
  constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
  parameter Modelica.SIunits.Inertia Jr "rotor's moment of inertia";
  //parameter Boolean useSupport=false "enable / disable (=fixed stator) support"
    annotation(Evaluate=true);
  parameter Modelica.SIunits.Inertia Js(start=Jr) "stator's moment of inertia" 
    annotation(Dialog(enable=useSupport));
  output Modelica.SIunits.Angle phiMechanical = flange.phi-internalSupport.phi
    "mechanical angle of rotor against stator";
  output Modelica.SIunits.AngularVelocity wMechanical(displayUnit="1/min") = der(phiMechanical)
    "mechanical angular velocity of rotor against stator";
  output Modelica.SIunits.Torque tauElectrical = inertiaRotor.flange_a.tau
    "electromagnetic torque";
  output Modelica.SIunits.Torque tauShaft = -flange.tau "shaft torque";
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange 
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=Jr) 
    annotation (Placement(transformation(
        origin={70,0},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "support at which the reaction torque is acting" 
       annotation (Placement(transformation(extent={{90,-110},{110,-90}},
          rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=Js) 
    annotation (Placement(transformation(
        origin={70,-100},
        extent={{10,10},{-10,-10}},
        rotation=180)));
protected
  Modelica.Mechanics.Rotational.Interfaces.Flange_a internalSupport 
    annotation (Placement(transformation(extent={{16,-104},{24,-96}},
          rotation=0)));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-40,60},{80,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Rectangle(
          extent={{-40,60},{-60,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{80,10},{100,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-40,70},{40,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},{80,
              -100},{-50,-100},{-50,-90}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-120},{150,-180}},
          lineColor={0,0,255},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Rectangle(
          extent={{80,-80},{120,-120}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          visible=not useSupport,
          points={{80,-100},{120,-100}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          visible=not useSupport,
          points={{90,-100},{80,-120}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          visible=not useSupport,
          points={{100,-100},{90,-120}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          visible=not useSupport,
          points={{110,-100},{100,-120}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          visible=not useSupport,
          points={{120,-100},{110,-120}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<HTML>
Base partial model DC machines:
<ul>
<li>main parts of the icon</li>
<li>mechanical shaft</li>
<li>mechanical support</li>
</ul>
Besides the mechanical connector <i>flange</i> (i.e. the shaft) the machines have a second mechanical connector <i>support</i>.<br>
If <i>useSupport</i> = false, it is assumed that the stator is fixed.<br>
Otherwise reaction torque (i.e. airGap torque, minus acceleration torque for stator's moment of inertia) can be measured at <i>support</i>.<br>
One may also fix the the shaft and let rotate the stator; parameter Js is only of importance when the stator is rotating.
</HTML>"),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),
            graphics));
equation
  connect(inertiaRotor.flange_b, flange) 
                                        annotation (Line(points={{80,
          -1.22465e-015},{92,-1.22465e-015},{92,0},{100,0}},
                                                           color={0,0,0}));
  connect(inertiaStator.flange_b, support) 
    annotation (Line(points={{80,-100},{100,-100}}, color={0,0,0}));
  connect(internalSupport, inertiaStator.flange_a) annotation (Line(
      points={{20,-100},{20,-96},{50,-96},{50,-100},{60,-100}},
      color={0,0,0},
      smooth=Smooth.None));
end PartialBasicMachine;
