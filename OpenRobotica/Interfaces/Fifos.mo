within OpenRobotica.Interfaces;
package Fifos

  block RealArray2ControllerOld "Read and write real array to fifo"

    function openFifoOutWrp
    input String fifoName;
    input Integer dummy;  // force execution order in equation sections
    output Integer fd;
    algorithm
      fd :=openFifoOut(fifoName);
    end openFifoOutWrp;

    function openFifoInWrp
    input String fifoName;
    input Integer dummy;  // force execution order in equation sections
    output Integer fd;
    algorithm
      fd :=openFifoIn(fifoName);
    end openFifoInWrp;

    function determineNextWriteEvent
                                     // workaround for problem in the equation section
    input Real fromfifoWE;
    input Real lastWE;
    output Real nextWE;
    algorithm
      //if (fromfifoWE == 0) then
      //  nextWE := lastWE;
      //else
        nextWE := fromfifoWE;
      //end if;
    end determineNextWriteEvent;

    parameter String FifoName="ModelicaFifo";
    parameter Integer Nin=1 "Number of inputs from fifo";
    parameter Integer Nout=1 "Number of outputs to fifo";
    parameter Real CompTime=1e-12 "Computation time of controller";
    parameter Boolean IsServer=true
      "Indicates if model creates the fifo and opens for writing first";
    //output Real varin[Nin]; //[Nin];
    //input Real varout[Nout];
    Modelica.Blocks.Interfaces.RealInput varout[Nout]
      "Connector of Real vector to be send to fifo";
    Modelica.Blocks.Interfaces.BooleanInput interrupt=false
      "Send to and recieve from fifo when interrupt/event becomes true";
    Modelica.Blocks.Interfaces.RealOutput varin[Nin]
      "Connector of Real vector, recieved from fifo";
  protected
    discrete Real dvarout[Nout];
    discrete Real dvarin[Nin];
    discrete Real nextWriteEventBuf(start=0);
    discrete Real nextWriteEvent(start=0);
    discrete Real nextReadEvent(start=0);
    //discrete Integer nextReadEvent(start=0);
    discrete Integer fd_in; // File descriptor
    discrete Integer fd_out;
    discrete Integer retval;
    discrete Integer numwritten[Nout];
    discrete Integer timewritten;
  equation
    when (time >= pre(nextWriteEvent) or interrupt) then
      for i in 1:Nout loop //index auch uebergeben
        dvarout[i] = varout[i];
        numwritten[i] = fifoOutReal(fd_out, dvarout[i], i, Nout+1); //write2fifo
      end for;
      if interrupt then
        timewritten = fifoOutReal(fd_out, time, 0, Nout+1);  // send SimTime
      else
        timewritten = fifoOutReal(fd_out, nextWriteEvent, 0, Nout+1);  // send SimTime==nextWriteEvent
      end if;
      nextReadEvent = time + CompTime;
    end when;

    when (time > pre(nextReadEvent)) then
    //when (nextReadEvent >= 1) then //!!! change() geht in OM nur mit Real
      for i in 1:Nin loop
        dvarin[i] = fifoInReal(fd_in, i, Nin+1);
        varin[i] = dvarin[i];
      end for;
      nextWriteEventBuf = fifoInReal(fd_in, 0, Nin+1);
      nextWriteEvent = if (nextWriteEventBuf <= 0) then nextWriteEvent else nextWriteEventBuf; //if else didnt work
      //pre(nextWriteEvent) doesnt work...
      //nextWriteEvent = nextWriteEventBuf;
    end when;

    when initial() then
          retval = createFifo(FifoName);
          fd_out = openFifoOutWrp(FifoName, retval);
          fd_in = openFifoInWrp(FifoName, fd_out);
    end when;
    when terminal() then
      // end of sim
    end when;
  end RealArray2ControllerOld;

  function fifoOutReal "Writes real values to fifo"
    input Integer fd;
    input Real varout;
    input Integer id;
    input Integer size;
    output Integer numwritten;
  external "C" 
    numwritten=  fifoOutReal(fd,varout, id, size) annotation(Library="modelicafifos.a",
                            Include="#include \"modelicafifos.h\"",
                            IncludeDirectory="modelica://OpenRobotica/Resources/include",
                            LibraryDirectory="modelica://OpenRobotica/Resources/lib");
  end fifoOutReal;

  function fifoInReal "Reads real values from fifo"
    input Integer fd;
    input Integer id;
    input Integer size;
    output Real realval;
  external "C" 
    realval = 
             fifoInReal(fd, id, size) annotation(Library="modelicafifos.a",
                            Include="#include \"modelicafifos.h\"",
                            IncludeDirectory="modelica://OpenRobotica/Resources/include",
                            LibraryDirectory="modelica://OpenRobotica/Resources/lib");
  end fifoInReal;

  function openFifoOut "Open fifo for writing and return file descriptor"
    input String fifoName;
    output Integer fd;
  external "C";
    annotation(Library="modelicafifos.a",
                            Include="#include \"modelicafifos.h\"",
                            IncludeDirectory="modelica://OpenRobotica/Resources/include",
                            LibraryDirectory="modelica://OpenRobotica/Resources/lib");
  end openFifoOut;

  function openFifoIn "Open fifo for reading and return file descriptor"
    input String fifoName;
    output Integer fd;
  external "C";
    annotation(Library="modelicafifos.a",
                            Include="#include \"modelicafifos.h\"",
                            IncludeDirectory="modelica://OpenRobotica/Resources/include",
                            LibraryDirectory="modelica://OpenRobotica/Resources/lib");
  end openFifoIn;

  function createFifo "Create pair .in and .out fifo"
    input String fifoName;
    output Integer retval;
  external "C";
    annotation(Library="modelicafifos.a",
                            Include="#include \"modelicafifos.h\"",
                            IncludeDirectory="modelica://OpenRobotica/Resources/include",
                            LibraryDirectory="modelica://OpenRobotica/Resources/lib");
  end createFifo;

  function createOpenFifo2Controller "Open 1st output an 2nd input fifo"
    input String fifoName;
    output Integer fd_out;
    output Integer fd_in;
  protected
    Integer retval;
  algorithm
    retval := createFifo(fifoName);
    fd_out := openFifoOut(fifoName);
    fd_in := openFifoIn(fifoName);
  end createOpenFifo2Controller;

  model TestArrayReturn "How to return an external array"
    parameter String FileName="myfile";
    Real varx;
  protected
    discrete Integer fds[2]; // File descriptors
  equation
    varx=1;
    fds = if initial() then returnArray(FileName,3) else pre(fds);
    //when initial() then
     // fds = CreateAndOpenFile(FileName);
    //end when;

  end TestArrayReturn;

  function returnArray "Test returning arrays"
    input String fifoName;
    input Integer id;
    output Integer fds[2];
    //Real retvals[3] = array(3.0,1,5);
  algorithm
    fds[1] := 3*id;//retvals[id];
    fds[2] := 2;
  end returnArray;

  class FdPair "Out- and input fifo file descriptor"
    Integer fd_o;
    Integer fd_i;
  end FdPair;

  block RealArray2Controller "Read and write real array to fifo"

    function openFifoOutWrp
    input String fifoName;
    input Integer dummy;  // force execution order in equation sections
    output Integer fd;
    algorithm
      fd :=openFifoOut(fifoName);
    end openFifoOutWrp;

    function openFifoInWrp
    input String fifoName;
    input Integer dummy;  // force execution order in equation sections
    output Integer fd;
    algorithm
      fd :=openFifoIn(fifoName);
    end openFifoInWrp;

    parameter String FifoName="ModelicaFifo";
    parameter Integer Nin=1 "Number of inputs from fifo";
    parameter Integer Nout=1 "Number of outputs to fifo";
    parameter Real CompTime=1e-9 "Computation time of controller";
    parameter Boolean IsServer=true
      "Indicates if model creates the fifo and opens for writing first";

    Modelica.Blocks.Interfaces.RealInput varout[Nout]
      "Connector of Real vector to be send to fifo" 
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
    Modelica.Blocks.Interfaces.BooleanInput interrupt=false
      "Send to and recieve from fifo when interrupt/event becomes true" 
      annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
    Modelica.Blocks.Interfaces.RealOutput varin[Nin](start=zeros(Nin))
      "Connector of Real vector, recieved from fifo" 
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  protected
    discrete Real nextWriteEventBuf(start=0);
    discrete Real nextWriteEvent(start=0);
    discrete Real nextReadEvent(start=Modelica.Constants.inf);
    Boolean writeEvent(start=false);
    Boolean readEvent(start=false);
    Integer fd_in; // File descriptor
    Integer fd_out;
    Integer retval;
    Integer numwritten[Nout];
    Integer timewritten;

  algorithm
    when initial() then
         retval := createFifo(FifoName);
          fd_out := openFifoOutWrp(FifoName, retval);
         fd_in := openFifoInWrp(FifoName, fd_out);
    end when;

    writeEvent := time >= nextWriteEvent;
    readEvent := time >= nextReadEvent;
  //  when { edge(writeEvent), initial()} then
    when { writeEvent, interrupt, initial()} then // edge(writeEvent)
      for i in 1:Nout loop //index auch uebergeben
        numwritten[i] :=fifoOutReal(fd_out, varout[i], i, Nout + 1);   //write2fifo
      end for;
      if interrupt then
        timewritten := fifoOutReal(fd_out, time, 0, Nout + 1);  // send SimTime
      else
        timewritten := fifoOutReal(fd_out, nextWriteEvent, 0,  Nout + 1); // send SimTime==nextWriteEvent
      end if;
      nextReadEvent :=time + CompTime;
      nextWriteEvent := Modelica.Constants.inf;
    elsewhen { readEvent} then  // edge(readEvent)
      nextWriteEventBuf := fifoInReal(fd_in, 0, Nin+1);
      if (nextWriteEventBuf > 0) then
        nextWriteEvent := nextWriteEventBuf; //sonst Interrupt
      end if;
      for i in 1:Nin loop // Array lesen
        varin[i] := fifoInReal(fd_in, i, Nin+1);
      end for;
      nextReadEvent := Modelica.Constants.inf;
    end when;

    //when terminal() then
      // end of sim
    //end when;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics));
  end RealArray2Controller;

end Fifos;
