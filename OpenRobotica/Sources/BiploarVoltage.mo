within OpenRobotica.Sources;
model BiploarVoltage
  parameter Modelica.SIunits.Voltage Vdc=540 "Value of DC voltage";
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
    annotation (extent=[-110,-12; -90,8]);
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
    annotation (extent=[88,-10; 108,10]);
  Modelica.Electrical.Analog.Basic.Ground gnd;
  Modelica.Electrical.Analog.Sources.ConstantVoltage udc_h(V=Vdc/2);
  Modelica.Electrical.Analog.Sources.ConstantVoltage udc_l(V=Vdc/2);
equation
  connect(p, udc_h.p);
  connect(n, udc_l.n);
  connect(udc_h.n, gnd.p);
  connect(udc_l.p, gnd.p);
end BiploarVoltage;
