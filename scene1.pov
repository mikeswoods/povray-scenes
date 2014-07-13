#include "colors.inc"    // The include files contain
#include "stones.inc"    // pre-defined scene elements
#include "textures.inc"

#macro cone1(X, Y, Z)
	cone {
		<X, 4, Z>, 0.0
		<X, Y, Z>, 0.5
		texture { 
			T_Stone13 
			scale 3 
		}
	}
#end

#macro column_1(X, Y, Z, COL_HEIGHT, COL_WIDTH, BASE_HEIGHT, BASE_WIDTH)
	#declare BASE_WIDTH_OFFSET = BASE_WIDTH / 2;
	box {
		<X-BASE_WIDTH_OFFSET, Y+COL_HEIGHT, Z-BASE_WIDTH_OFFSET>
		<X+BASE_WIDTH_OFFSET, Y+COL_HEIGHT+BASE_HEIGHT, Z+BASE_WIDTH_OFFSET>
		texture { 
			White_Marble 
			scale 2.0  
		}
	}
	cylinder {
		<X, Y, Z>
		<X, Y+COL_HEIGHT, Z>
		COL_WIDTH
		texture { 
			T_Stone8
			scale 4.0
			rotate x*90
			finish { 
				ambient -0.2
				phong 0.8 
			} 
		}
	}
	box {
		<X-BASE_WIDTH_OFFSET, Y-BASE_HEIGHT, Z-BASE_WIDTH_OFFSET>
		<X+BASE_WIDTH_OFFSET, Y+BASE_HEIGHT, Z+BASE_WIDTH_OFFSET>
		texture { 
			White_Marble 
			scale 2.5 
		} 
	}
#end

camera {
	location <1, 1.5, -10>
	look_at  <0, 2,  0>
}

light_source { 
	<5, 15, -15> 
	color White
}

#declare SPACING = 8;
#declare START_X = -5;
#declare START_Z = -3;
#declare MAX_X_COLS = 5;
#declare MAX_Z_COLS = 125;
#declare COL_X_COUNT = 0;
#declare COL_Z_COUNT = 0;
#declare BASE_WIDTH = 1.0;
#declare COL_WIDTH = 0.5;
#declare BASE_HEIGHT = 0.15;

#while (COL_Z_COUNT < MAX_Z_COLS)
	#declare POS_Z = START_Z + (COL_Z_COUNT * (BASE_WIDTH + SPACING));
	//column_1(-8 , 0, POS_Z, 4, COL_WIDTH, BASE_HEIGHT, 1.5)
	column_1(-2.5 , 0, POS_Z, 4, COL_WIDTH, BASE_HEIGHT, 1.5)
	column_1(2.5 , 0, POS_Z, 4, COL_WIDTH, BASE_HEIGHT, 1.5)
	//column_1(8 , 0, POS_Z, 4, COL_WIDTH, BASE_HEIGHT, 1.5)
	#declare COL_Z_COUNT = COL_Z_COUNT + 1;
#end
	
//column_1(0 ,0, 0, 4, 0.5, 0.25, BASE_WIDTH)

plane {
	<0, 1, 0>, 0
	texture {  
		T_Stone15 
		scale 10.0
		normal {
			bumps 1.0
			scale 0.5
		}
	}
}
plane { // Water
	<0, 1, 0>, 1
	pigment { 
		color Cyan 
		filter 0.4
		transmit 0.1
	}
	finish { 
		phong 0
		reflection 0.3
	}
	normal { 
		bumps 0.8
		scale 0.6
	}
	interior {
		ior 1.00
	}
}

plane{
	<0,1,0>,1 hollow 
    texture { 
		pigment {
			//color rgb<0.1,0.35,0.8>*0.8
			color MediumSlateBlue
		}
		finish {ambient 1  diffuse 0}
	}
	texture { 
		pigment { 
			bozo 
			turbulence 0.1
			octaves 1  omega 0.7 lambda 2 
			color_map {
                          [0.0  color rgb <0.95, 0.95, 0.95> ]
                          [0.05  color rgb <1, 1, 1>*1.25 ]
                          [0.15 color rgb <0.85, 0.85, 0.85> ]
                          [0.55 color rgbt <1, 1, 1, 1>*1 ]
                          [1.0 color rgbt <1, 1, 1, 1>*1 ]
                          } // end color_map 
                         translate< 3, 0,-1>
                         scale <0.3, 0.4, 0.2>*3
                        } // end pigment
                 finish {ambient 1 diffuse 0}
               } // end texture 2

      scale 10000}  
// fog at the horizon     
fog{distance 300000 color White}