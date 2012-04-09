within OpenRobotica.Machines.Xcopter;
model MotorDC "Nur ein bloeder Energiewandler :-)"
extends OpenRobotica.Machines.PartialBasicMachine;

  parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="1/min", start=1425*2*pi/60)
    "nominal speed";
  parameter Modelica.SIunits.AngularVelocity konstante = 1;
  parameter Modelica.SIunits.Voltage VaNominal(start=15)
    "nominal armature voltage";
  parameter Modelica.SIunits.Resistance Ra(start=0.35)
    "warm armature resistance";

  Xcopter.MotorDCAirGap airgap(psi_e=VaNominal/wNominal) 
                       annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=270,
        origin={-10,0})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_ap 
    annotation (Placement(transformation(extent={{50,110},{70,90}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_an 
    annotation (Placement(transformation(extent={{-70,110},{-50,90}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor ra(final R=Ra) 
    annotation (Placement(transformation(extent={{60,50},{40,70}}, rotation=
           0)));
  output Modelica.SIunits.Voltage va = pin_ap.v-pin_an.v "armature voltage";
  output Modelica.SIunits.Current ia = pin_ap.i "armature current";
equation
  connect(pin_ap,ra.p) 
    annotation (Line(points={{60,100},{60,60}}, color={0,0,255}));
  connect(airgap.pin_ap, ra.n) annotation (Line(
      points={{1.77636e-015,10},{20,10},{20,60},{40,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(airgap.pin_an, pin_an) annotation (Line(
      points={{-20,10},{-60,10},{-60,100}},
      color={0,0,255},
      smooth=Smooth.None));
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
end MotorDC;
