within OpenRobotica.Converters.Continous;
model PowerConverterIdealVSk
  "Sets output voltage whilst keeping in- and output power equal"
 extends OpenRobotica.Interfaces.Electrical.SupplyPort;
 extends OpenRobotica.Interfaces.Electrical.LoadPort;
  Modelica.Blocks.Interfaces.RealInput kRef "Gain of input voltage" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={106,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={96,0})));
equation
 vLoad = kRef * vSupply;
 powerSupply = powerLoad;
  annotation (Icon(graphics), Diagram(graphics));
end PowerConverterIdealVSk;
