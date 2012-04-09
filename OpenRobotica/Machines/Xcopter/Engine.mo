within OpenRobotica.Machines.Xcopter;
model Engine "BL motor with MK controller"
  constant Modelica.SIunits.Angle pi = Modelica.Constants.pi;
  parameter Modelica.SIunits.Inertia Jr "rotor's moment of inertia";
  parameter Modelica.SIunits.Inertia Js "stator's moment of inertia";
  parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit = "rad/s", start = 115)
    "nominal speed";
  parameter Modelica.SIunits.Voltage VaNominal(start = 1)
    "nominal armature voltage";
  parameter Modelica.SIunits.Resistance Ra = 0.33 "warm armature resistance";
  parameter Modelica.SIunits.Inductance La = 3.5e-05 "armature inductance";
  parameter Modelica.SIunits.Frequency f_pwm = 16000 "PWM frequency";
  Xcopter.MotorIdeal motor(
    final Jr=Jr,
    final wNominal=wNominal,
    final VaNominal=VaNominal,
    Js=Js) 
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Xcopter.BlCtrl blCtrl(
    Ra=Ra,
    La=La,
    f_pwm=f_pwm) 
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Electrical.Analog.Basic.Ground ground 
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p 
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n 
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Support support 
    annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Blocks.Interfaces.RealInput pwm_cmd(min = 0, max = 1)  annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-50,60},{70,-60}}),
        Rectangle(
          fillColor={128,128,128},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{90,60},{70,-60}}),
        Rectangle(
          fillColor={95,95,95},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-70,10},{-50,-10}}),
        Rectangle(
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-50,70},{30,50}}),
        Polygon(fillPattern=FillPattern.Solid, points={{-60,-90},{-50,-90},{-20,
              -20},{30,-20},{60,-90},{70,-90},{70,-100},{-60,-100},{-60,-90}})}),
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics));
equation
  connect(pin_n, blCtrl.n1) annotation (Line(
      points={{-40,100},{-40,-35},{-20,-35}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pin_p, blCtrl.p1) annotation (Line(
      points={{40,100},{40,80},{-30,80},{-30,-25},{-20,-25}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground.p, motor.pin_an) annotation (Line(
      points={{30,-50},{38,-50},{38,-40},{44,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(blCtrl.n2, motor.pin_an) annotation (Line(
      points={{0,-35},{22,-35},{22,-40},{44,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(blCtrl.p2, motor.pin_ap) annotation (Line(
      points={{0,-25},{24,-25},{24,-30},{56,-30},{56,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pwm_cmd, blCtrl.pwm_cmd) annotation (Line(
      points={{100,0},{-10,0},{-10,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(motor.flange, flange_a) annotation (Line(
      points={{60,-50},{70,-50},{70,-70},{-80,-70},{-80,0},{-100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(motor.support, support) annotation (Line(
      points={{60,-60},{60,-80},{-100,-80}},
      color={0,0,0},
      smooth=Smooth.None));
end Engine;
