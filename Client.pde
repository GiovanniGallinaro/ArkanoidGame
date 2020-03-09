
//import oscP5.*;
//import netP5.*;

//OscP5 oscP5;
//NetAddress myRemoteLocation;



//float positionX ;
//float positionY ;

////setup
////oscP5 = new OscP5(this, 12000);//da che porta riceverò i dati


//void oscEvent(OscMessage theOscMessage) {
//  /* check if theOscMessage has the address pattern we are looking for. */
//  if (theOscMessage.checkAddrPattern("/position")==true) {
//    /* check if the typetag is the right one. */
//    if (theOscMessage.checkTypetag("ff")) {
//      /* parse theOscMessage and extract the values from the osc message arguments. */
//      positionX = theOscMessage.get(0).floatValue(); // get the second osc argument
//      positionY = theOscMessage.get(1).floatValue(); // get the second osc argument

//      println(" values: "+positionX+", "+positionY);
//      return;
//    }
//  }
//  println("### received an osc message. with address pattern "+
//    theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
//}
