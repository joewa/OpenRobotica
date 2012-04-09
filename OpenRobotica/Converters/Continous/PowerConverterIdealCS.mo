within OpenRobotica.Converters.Continous;
model PowerConverterIdealCS
  "Sets output current whilst keeping in- and output power equal"
 extends OpenRobotica.Interfaces.Electrical.SupplyPort;
 extends OpenRobotica.Interfaces.Electrical.LoadPort;
  Modelica.Blocks.Interfaces.RealInput iRef "Reference output current" 
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={106,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={96,0})));
 constant Modelica.SIunits.Current iUnit=1;
equation
 iLoad = iRef * iUnit;
 powerSupply = powerLoad;
  annotation (Icon(graphics), Diagram(graphics));
end PowerConverterIdealCS;
