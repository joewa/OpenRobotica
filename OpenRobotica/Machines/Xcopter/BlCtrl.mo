within OpenRobotica.Machines.Xcopter;
model BlCtrl
  "MK-Motor-Spannungswandler- mit PWM 0 bis 1MK-Motor-Spannungswandler- mit PWM 0 bis 1"

  extends Modelica.Electrical.Analog.Interfaces.TwoPort;
  extends Xcopter.BlParam;

  //Modell mit Mikrokopter-Verstaerker
  Modelica.Blocks.Interfaces.RealInput pwm_cmd(min=0, max=1) 
                                                        annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));

  Modelica.SIunits.Power p_in(start=0);
  Modelica.SIunits.Power p_out(start=0);

equation
//  vBatt = v1;
//  iBatt = i1;
//  bemf = v2;
//  ia = i2;

  i2 = DiscontCurrent(pwm_cmd, v1, v2, Ra, La, f_pwm);
  p_in = v1*i1;
  p_out = -v2*i2 + Ra*i2^2;
//  p_in = vBatt*iBatt;
//  p_out = bemf*ia + Ra*ia^2;
  p_in = p_out;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}),
        Line(
          points={{-100,-100},{100,100}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,40},{0,40}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{-60,20},{0,20}},
          color={0,0,255},
          smooth=Smooth.None)}));
end BlCtrl;
