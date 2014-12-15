/**
 * Displays the subway lines of Boston, read from a GeoJSON file.
 * 
 * This example shows how to load data features and create markers manually in order to map specific properties; in this
 * case the colors according to the MBTA schema.
 */
import java.io.*;
import java.util.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import java.util.List;

Location bostonLocation = new Location(42.357778f, -71.061667f);

UnfoldingMap map;
Double[][] locations;
Double[][] locations1;
void setup() {
  locations=new Double[75552][4];
  locations1=new Double[30000][8];
  size(1000, 800, OPENGL);
  //smooth();

  map = new UnfoldingMap(this,new StamenMapProvider.TonerBackground());
  MapUtils.createDefaultEventDispatcher(this, map);
  
  map.zoomToLevel(14);
  map.panTo(bostonLocation);
  map.setZoomRange(9, 17); // prevent zooming too far out
  map.setPanningRestriction(bostonLocation, 50);
  List<Feature> transitLines;

  transitLines = GeoJSONReader.loadData(this, "/Users/waleedgowharji/Desktop/waleed/TransitLineMarkerApp/data/MBTARapidTransitLines.json");
 
  // Create marker from features, and use LINE property to color the markers.
  List<Marker> transitMarkers = new ArrayList<Marker>();
  for (Feature feature : transitLines) {
    ShapeFeature lineFeature = (ShapeFeature) feature;

    SimpleLinesMarker m = new SimpleLinesMarker(lineFeature.getLocations());
    String lineColor = lineFeature.getStringProperty("LINE");
    color col = 0;
    // Original MBTA colors
    if (lineColor.equals("BLUE")) {
      col = color(44, 91, 167);
    }
    if (lineColor.equals("RED")) {
      col = color(233, 57, 35);
    }
    if (lineColor.equals("GREEN")) {
      col = color(59, 200, 79);
    }
    if (lineColor.equals("SILVER")) {
      col = color(154, 156, 157);
    }
    if (lineColor.equals("ORANGE")) {
      col = color(238, 137, 40);
    }
    m.setColor(col);
    m.setStrokeWeight(5);
   transitMarkers.add(m);
  }
  map.addMarkers(transitMarkers);
    BufferedReader reader;
    String line;
    int i;
    String[] parts;
     try{
             reader = new BufferedReader(new FileReader("/Users/waleedgowharji/Desktop/waleed/TransitLineMarkerApp/data/nodes.csv"));
             line = null;
             i=0;
            while ((line = reader.readLine()) != null) 
            {  
                parts = line.split(",");
                locations[i][0]=Double.parseDouble(parts[0]);//node index
                locations[i][1]=Double.parseDouble(parts[1]);//node lat
                locations[i][2]=Double.parseDouble(parts[2]);//node lon
                locations[i][3]=Double.parseDouble(parts[3]);//nodal value
                //parse the string values to int and double 
                i++;
            }

       }
        catch(IOException ex)
        {
          System.out.println("you have an error");
        }
               
 // read edges
  BufferedReader reader1;
    String line1;
    int i1;
    String[] parts1;
     try{

             reader1 = new BufferedReader(new FileReader("/Users/waleedgowharji/Desktop/waleed/TransitLineMarkerApp/data/edges.csv"));
             line1 = null;
             i1=0;
            
            while ((line1 = reader1.readLine()) != null) 
            {  
                parts1 = line1.split(",");
                locations1[i1][0]=Double.parseDouble(parts1[0]);//node index
                locations1[i1][1]=Double.parseDouble(parts1[1]);//node lat
                locations1[i1][2]=Double.parseDouble(parts1[2]);//node lon
                locations1[i1][3]=Double.parseDouble(parts1[3]);//nodal value
                locations1[i1][4]=Double.parseDouble(parts1[4]);//nodal value
                locations1[i1][5]=Double.parseDouble(parts1[5]);//nodal value
                locations1[i1][6]=Double.parseDouble(parts1[6]);//nodal value
                locations1[i1][7]=Double.parseDouble(parts1[7]);//nodal value
                System.out.println(i1 +"  " +locations1[i1][2]+"  "+locations1[i1][3]);
                //parse the string values to int and double 
                i1++;
                System.out.println("i1++ === "+i1);               
            }
       }
        catch(IOException ex)
        {
          System.out.println("you have an error");
        }  
}

void draw() {
  map.draw();
    ScreenPosition berlinPos=null;
    ScreenPosition berlinPos1=null;
    Location dummy ;
    Location dummy1 ;
    for(int a=0;a<locations.length;a++)
    {
      if(a==121)
      break;

      dummy= new Location(locations[a][2],locations[a][1]);
      SimplePointMarker Marker = new SimplePointMarker(dummy);
      berlinPos = Marker.getScreenPosition(map);
   
      strokeWeight(3);
      
      fill(0,200,230);
      stroke(0, 0, 0, 255);
      
        ellipse(berlinPos.x, berlinPos.y, (int)(Math.floor(locations[a][3])/7)+10,(int)(Math.floor(locations[a][3])/7)+10 );
    }
    //edges
    for(int a=0;a<locations1.length;a++)
    {
      strokeWeight(.8);
      stroke(255,50,50);
      System.out.println(a + " SS " +locations1[a][3]+" "+locations1[a][4] );
      System.out.println(a + " SS " +locations1[a][5]+" "+locations1[a][6] );
      if(a==300)
      break;
      System.out.println("Hello world  " + a);
      dummy= new Location(locations1[a][4],locations1[a][5]);
      dummy1= new Location(locations1[a][6],locations1[a][7]);
      SimplePointMarker Marker = new SimplePointMarker(dummy);
      berlinPos = Marker.getScreenPosition(map);  
      SimplePointMarker Marker1 = new SimplePointMarker(dummy1);
      berlinPos1 = Marker1.getScreenPosition(map);
      line(berlinPos.x,berlinPos.y,berlinPos1.x,berlinPos1.y);
    }
}

