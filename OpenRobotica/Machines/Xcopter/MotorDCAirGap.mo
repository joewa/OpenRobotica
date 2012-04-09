within OpenRobotica.Machines.Xcopter;
model MotorDCAirGap "Nestet, weil braucht ja eh kein Mensch :-D"

  Modelica.SIunits.AngularVelocity w "Angluar velocity";
  parameter Modelica.SIunits.MagneticFlux psi_e = 1 "Excitation flux";
  Modelica.SIunits.Voltage vai "Induced armature voltage";
  Modelica.SIunits.Current ia "Armature current";
  output Modelica.SIunits.Torque tauElectrical;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft 
  annotation (Placement(transformation(extent={{-10,110},{10,90}},
        rotation=0)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a support
    "support at which the reaction torque is acting" 
     annotation (Placement(transformation(extent={{-10,-110},{10,-90}},
        rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
  annotation (Placement(transformation(extent={{-110,110},{-90,90}},
        rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}},
          rotation=0)));

equation
  // armature pins
  vai = pin_ap.v - pin_an.v;
  ia = + pin_ap.i;
  ia = - pin_an.i;
  // mechanical speed
  w = der(shaft.phi)-der(support.phi);
  // induced armature voltage
  vai = -psi_e * w;
  // electrical torque (ia is perpendicular to flux)
  tauElectrical = psi_e * ia;
  shaft.tau = tauElectrical;
  support.tau = -tauElectrical;
end MotorDCAirGap;
