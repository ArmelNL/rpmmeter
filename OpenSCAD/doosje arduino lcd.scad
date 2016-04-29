$fn = 60;
hoogte = 5;
lcd_breedte = 36;
lcd_lengte = 80;
lcd_marge = 20+17.3;

lcd_scherm_lengte = 71.5;
lcd_scherm_breedte = 24.2;

lcd_standoffheight = 7;

arduino_breedte = 53.3;
arduino_lengte = 68.6;
arduino_hoogte=5;
arduino_standoffhoogte = 7; 
arduino_marge = 20;
wall_width = 2.4;
box_height = 50;

module standoff(standoffhoogte){
    difference(){
        cylinder(r1=4,r2=2.5,h=standoffhoogte);
        cylinder(r=1.3,h=standoffhoogte);
    }
}

module screen(){ 
    difference(){

        cube([lcd_breedte+lcd_marge,lcd_lengte+lcd_marge,hoogte]);

        translate([lcd_marge/2,lcd_marge/2,0]){
            translate([(lcd_breedte - lcd_scherm_breedte)/2,(lcd_lengte - lcd_scherm_lengte)/2,0])
            cube([lcd_scherm_breedte,lcd_scherm_lengte,hoogte]);
        }
    }
    translate([lcd_marge/2,lcd_marge/2,hoogte]){
        translate([1.4,1.4,0])
        standoff(lcd_standoffheight);

        translate([lcd_breedte-1.4,1.4,0])
        standoff(lcd_standoffheight);

        translate([lcd_breedte-1.4,lcd_lengte-1.4,0])
        standoff(lcd_standoffheight);

        translate([1.4,lcd_lengte-1.4,0])
        standoff(lcd_standoffheight);
    }
        translate([5,5,hoogte])
        standoff(box_height-arduino_hoogte);
        
        translate([arduino_breedte+arduino_marge-5,5,hoogte])
        standoff(box_height-arduino_hoogte);
    
        translate([(arduino_breedte+arduino_marge)/2,lcd_lengte+lcd_marge-5,hoogte])
        standoff(box_height-arduino_hoogte);
    
}

module arduino()
{
    difference(){
    cube([arduino_breedte+arduino_marge,arduino_lengte+arduino_marge+((lcd_lengte+lcd_marge)-(arduino_lengte+arduino_marge)),arduino_hoogte]);
        translate([5,5,0])
        cylinder(r=1.4,h=arduino_hoogte);
        
        translate([arduino_breedte+arduino_marge-5,5,0])
        cylinder(r=1.4,h=arduino_hoogte);
        
        translate([(arduino_breedte+arduino_marge)/2,lcd_lengte+lcd_marge-5,0])
        cylinder(r=1.4,h=arduino_hoogte);
    }
    translate([arduino_marge/2,arduino_marge/2,arduino_hoogte])
    {
        translate([2.5,15,0])
        standoff(arduino_standoffhoogte);
        translate([arduino_breedte-2.5,14,0])
        standoff(arduino_standoffhoogte);
        translate([arduino_breedte-7.1,67.4-1.3,0])
        standoff(arduino_standoffhoogte);
        translate([arduino_breedte-7.1-27.9,67.4-1.3,0])
        standoff(arduino_standoffhoogte);
    }
    
    
    
    
    difference(){
        union(){
            //box around arduino
            translate([-wall_width,0,0])
            cube([wall_width,arduino_lengte+arduino_marge+((lcd_lengte+lcd_marge)-(arduino_lengte+arduino_marge)),box_height+arduino_hoogte]);
            
            translate([-wall_width,-wall_width,0])
            cube([arduino_breedte+arduino_marge+wall_width,wall_width,box_height+arduino_hoogte]);
            
            translate([arduino_breedte+arduino_marge,-wall_width,0])
            cube([wall_width,arduino_lengte+arduino_marge+((lcd_lengte+lcd_marge)-(arduino_lengte+arduino_marge))+wall_width,box_height+arduino_hoogte]);
            
            translate([-wall_width,arduino_lengte+arduino_marge+((lcd_lengte+lcd_marge)-(arduino_lengte+arduino_marge)),0])
            cube([arduino_breedte+arduino_marge+wall_width+wall_width,wall_width,box_height+arduino_hoogte]);
        }
        translate([10,arduino_lengte+wall_width+arduino_marge+((lcd_lengte+lcd_marge)-(arduino_lengte+arduino_marge)),15])
        rotate([90,0,0])
        cylinder(h=wall_width,r=5);
    }
    
}



arduino();
translate([arduino_breedte+arduino_marge+10,0,0])
screen();

//arduino_lcd_box();


// Arduino/lcd module onderkant
module arduino_lcd_box()
{
    cube([arduino_breedte+arduino_marge,arduino_lengte+arduino_marge,arduino_hoogte]);
    translate([0,arduino_lengte+arduino_marge,0])
    cube([lcd_breedte+lcd_marge,lcd_lengte+lcd_marge,hoogte]);

    translate([-wall_width,0,0])
    cube([wall_width,arduino_lengte+arduino_marge+lcd_marge+lcd_lengte,box_height+arduino_hoogte]);

    translate([-wall_width,-wall_width,0])
    cube([wall_width+arduino_breedte+arduino_marge,wall_width,box_height+arduino_hoogte]);

    translate([arduino_breedte+arduino_marge,-wall_width,0])
    cube([wall_width,arduino_lengte+arduino_marge+wall_width,box_height+arduino_hoogte]);

    translate([lcd_breedte+lcd_marge,arduino_lengte+arduino_marge,0])
    cube([wall_width,lcd_lengte+lcd_marge+wall_width,box_height+arduino_hoogte]);

    translate([lcd_breedte+lcd_marge+wall_width,arduino_lengte+arduino_marge,0])
    cube([arduino_breedte+arduino_marge-lcd_breedte-lcd_marge,wall_width,box_height+arduino_hoogte]);

    translate([-wall_width,lcd_lengte+lcd_marge+arduino_lengte+arduino_marge,0])
    cube([lcd_breedte+lcd_marge+wall_width,wall_width,box_height+arduino_hoogte]);
    
    
}
