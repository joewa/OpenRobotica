within OpenRobotica.Machines;
model TorqueControlledDrive "Ideal DC powered torque controlled drive"
// nochmal drüber nachdenken: Geschwindigkeitsquelle machen!?
  extends PartialBasicMachine;
  extends OpenRobotica.Interfaces.Electrical.SupplyPort;
  parameter Modelica.SIunits.AngularVelocity Vmax=100 "Maximum speed";
  parameter Modelica.SIunits.Torque Tmax=1 "Maximum torque";
  parameter Modelica.SIunits.Power Pmax=100 "Maximum power";

  Modelica.SIunits.AngularVelocity w;
  Modelica.SIunits.Torque tauElectrical;
  Modelica.SIunits.Power p_mech;

equation
  w = der(inertiaRotor.flange_a.phi) - der(internalSupport.phi);
  p_mech = w * tauElectrical;
  inertiaRotor.flange_a.tau = tauElectrical;
  internalSupport.tau = -tauElectrical;
end TorqueControlledDrive;
