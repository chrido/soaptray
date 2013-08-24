

module rounded_base_box(x, y, z, rounding) {
	minkowski() {
 		cube([x,y,z]);
 		cylinder(r=rounding,h=1);
	}
}

module soaptray(x, y, z, thicknessFrame, totalbars) {
	echo("rendering a soapbox with x=", x, " and y=", y);

   lower = 2;
   
	rounding = (thicknessFrame*0.75);
	beginBars = (rounding/2) + thicknessFrame;
   barWidth = (x - (2*beginBars))/((totalbars*2)-1);
	echo("beginBars:", beginBars);
   echo("barWidth:", barWidth);

   countBars = (x-(2*beginBars))/((barWidth*2));
	
   union() {
	difference(){
		rounded_base_box(x, y, z, rounding);
   	translate([thicknessFrame, thicknessFrame, 0]) {
			rounded_base_box(x-(thicknessFrame*2), y-(thicknessFrame*2), z, rounding);
		}
	}
   
   difference() {
       for(i = [0 : countBars]) {
		     translate([(barWidth*i*2)+beginBars, 0, 0]) 
			  cube([barWidth, y, z]);
	    }
       //recess
       translate([(x/2),(y/2),thicknessFrame+(lower)]) 
           resize(newsize=[x-thicknessFrame-lower, y-thicknessFrame-lower, z]) 
               sphere(r=100);	
   }
   }
}


soaptray(120, 80, 10, 8, 12);



