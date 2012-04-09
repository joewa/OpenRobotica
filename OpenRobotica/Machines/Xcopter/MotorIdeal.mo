within OpenRobotica.Machines.Xcopter;
model MotorIdeal "Nur ein gaaaanz bloeder Energiewandler :-)"
extends OpenRobotica.Machines.PartialBasicMachine;

  parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="rad/s", start=115)
    "nominal speed";
  parameter Modelica.SIunits.Voltage VaNominal(start=1)
    "nominal armature voltage";

  Xcopter.MotorDCAirGap airgap(psi_e=VaNominal/wNominal) 
                       annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=270,
        origin={-10,0})));
  //MotorDCAirGap airgap;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
    annotation (Placement(transformation(extent={{50,110},{70,90}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
    annotation (Placement(transformation(extent={{-70,110},{-50,90}},
          rotation=0)));
  output Modelica.SIunits.Voltage va "armature voltage";
  output Modelica.SIunits.Current ia "armature current";
equation
  va = pin_ap.v-pin_an.v;
  ia = pin_ap.i;
  connect(inertiaRotor.flange_a, airgap.shaft) annotation (Line(
      points={{60,1.22465e-015},{30,1.22465e-015},{30,-1.83697e-015},{0,
          -1.83697e-015}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(airgap.support, internalSupport) annotation (Line(
      points={{-20,1.83697e-015},{-24,1.83697e-015},{-24,-100},{20,-100}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
  connect(pin_an, airgap.pin_an) annotation (Line(
      points={{-60,100},{-40,100},{-40,10},{-20,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pin_ap, airgap.pin_ap) annotation (Line(
      points={{60,100},{30,100},{30,10},{1.77636e-015,10}},
      color={0,0,255},
      smooth=Smooth.None));
end MotorIdeal;
